import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:chat_proto/chat_proto.dart';
import 'package:chat_proto/generated/update_status.pb.dart';
import 'package:chat_server/objectbox.g.dart';
import 'package:chat_server/src/features/local_storage/models/models.dart';
import 'package:chat_server/src/features/local_storage/services/channels_repo.dart';
import 'package:chat_server/src/features/local_storage/services/messages_repo.dart';

class ChatService extends ChatServiceBase {
  final Store store;
  final ChannelsRepo chatRepo;
  final MessagesRepo messageRepo;
  final StreamController<ChatMessage> _messageUpdatesStreamController =
      StreamController<ChatMessage>.broadcast();

  ChatService(this.store)
      : chatRepo = ChannelsRepo(store),
        messageRepo = MessagesRepo(store);

  clearAllData() async {
    await chatRepo.removeAll();
    await messageRepo.removeAll();
    log('All data cleared');
  }

  @override
  Future<CallStatusResponse> createChannel(
      ServiceCall call, ChatChannel request) async {
    final channel = request;
    final Uint8List data = channel.writeToBuffer();
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final cachedChannel = ChannelLocalRecord(
      channelId: channel.channelId,
      data: data,
      timestamp: timestamp,
    );

    await chatRepo.put(cachedChannel);
    return CallStatusResponse();
  }

  @override
  Future<ListChannelsResponse> listChannels(
      ServiceCall call, ListChannelsRequest request) async {
    final channels = await chatRepo.getAll();
    final response = ListChannelsResponse();
    response.channels
        .addAll(channels.map((e) => ChatChannel.fromBuffer(e.data)));
    return response;
  }

  @override
  Future<CallStatusResponse> sendMessage(
      ServiceCall call, ChatMessage request) async {
    final message = request;
    final accepted = UpdateStatus.ACCEPTED;
    final rejected = UpdateStatus.REJECTED;

    try {
      // prepare cached message
      final Uint8List data = message.writeToBuffer();
      final cachedMessage = MessagelocalRecord(
        channelId: message.channelId,
        data: data,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      );
      // save message to cache
      await messageRepo.put(cachedMessage);
      // notify subscribers about new message
      _messageUpdatesStreamController.add(message);
    } on Exception catch (e) {
      log('Error sending message: $e');
      // return rejected status
      final response = CallStatusResponse()
        ..status = rejected
        ..message = e.toString();
      return response;
    }
    final response = CallStatusResponse()
      ..status = accepted
      ..message = 'ok';
    return Future.value(response);
  }

  @override
  Stream<ChatMessage> streamMessageUpdates(
      ServiceCall call, StreamMessageUpdatesRequest request) {
    return _messageUpdatesStreamController.stream
        .where((message) => message.channelId == request.channelId);
  }

  @override
  Future<GetMessagesResponse> getMessages(
      ServiceCall call, GetMessagesRequest request) async {
    final channelId = request.channelId;
    final int from = request.from.seconds.toInt() * 1000;

    final messages =
        await messageRepo.getMessagesAfterTimestamp(channelId, from);
    final response = GetMessagesResponse();
    response.messages
        .addAll(messages.map((e) => ChatMessage.fromBuffer(e.data)));
    return response;
  }
}
