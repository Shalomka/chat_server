import 'dart:typed_data';

import 'package:chat_proto/chat_proto.dart';
import 'package:uuid/uuid.dart';

class ChatService extends ChatServiceBase {
  final Store store;
  final ChannelCacheRepo repo;

  ChatService(this.store) : repo = ChannelCacheRepo(store);

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

    await repo.put(cachedChannel);
    return CreateChannelResponse();
  }

  @override
  Future<ListChannelsResponse> listChannels(
      ServiceCall call, ListChannelsRequest request) async {
    final channels = await repo.getAll();
    final response = ListChannelsResponse();
    response.channels.addAll(channels.map((e) => Channel.fromBuffer(e.data)));
    return response;
  }

  @override
  Future<SendMessageResponse> sendMessage(
      ServiceCall call, SendMessageRequest request) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  Stream<MessageResponse> streamMessages(
      ServiceCall call, StreamMessagesRequest request) {
    // TODO: implement streamMessages
    throw UnimplementedError();
  }
}
