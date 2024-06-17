import 'dart:async';
import 'dart:typed_data';

import 'package:chat_proto/chat_proto.dart';
import 'package:uuid/uuid.dart';

class ChatService extends ChatServiceBase {
  final Store store;
  final ChannelCacheRepo chatRepo;
  final MessageCacheRepo messageRepo;
  final StreamController<MessageResponse> _messageStreamController =
      StreamController<MessageResponse>.broadcast();

  ChatService(this.store)
      : chatRepo = ChannelCacheRepo(store),
        messageRepo = MessageCacheRepo(store);

  @override
  Future<CreateChannelResponse> createChannel(
      ServiceCall call, CreateChannelRequest request) async {
    final channel = Channel()
      ..name = request.name
      ..channelId = request.channelId.isEmpty ? Uuid().v4() : request.channelId;
    final Uint8List data = channel.writeToBuffer();
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final cachedChannel = CachedChannel(
      channel.channelId,
      data,
      timestamp,
    );

    await chatRepo.put(cachedChannel);
    return CreateChannelResponse();
  }

  @override
  Future<ListChannelsResponse> listChannels(
      ServiceCall call, ListChannelsRequest request) async {
    final channels = await chatRepo.getAll();
    final response = ListChannelsResponse();
    response.channels.addAll(channels.map((e) => Channel.fromBuffer(e.data)));
    return response;
  }

  @override
  Future<SendMessageResponse> sendMessage(
      ServiceCall call, SendMessageRequest request) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    final message = MessageResponse()
      ..messageId = timestamp
      ..channelId = request.channelId
      ..text = request.text
      ..timestamp = Timestamp();
    final Uint8List data = message.writeToBuffer();
    final cachedMessage = CachedMessage(request.channelId, data, timestamp);
    messageRepo.put(cachedMessage);
    _messageStreamController.add(message);
    final response = SendMessageResponse()..channelId = request.channelId;
    return Future.value(response);
  }

  @override
  Stream<MessageResponse> streamMessages(
      ServiceCall call, StreamMessagesRequest request) {
    return _messageStreamController.stream
        .where((message) => message.channelId == request.channelId);
  }
}
