import 'package:chat_server/objectbox.g.dart';
import 'package:chat_server/src/features/local_storage/models/models.dart';
import 'package:chat_server/src/features/local_storage/services/local_data_repo.dart';

class MessagesRepo extends LocalDataRepo<MessagelocalRecord> {
  MessagesRepo(super.store);

  // get messages by channel id
  Future<List<MessagelocalRecord>> getMessagesByChannelId(
      String channelId) async {
    return box
        .query(MessagelocalRecord_.channelId.equals(channelId))
        .build()
        .find();
  }

  // remove all messages by channel id
  Future<int> removeAllMessagesByChannelId(String channelId) async {
    return box
        .query(MessagelocalRecord_.channelId.equals(channelId))
        .build()
        .remove();
  }

  // get messages after a timestamp
  Future<List<MessagelocalRecord>> getMessagesAfterTimestamp(
      String channelId, int timestamp) async {
    return box
        .query(MessagelocalRecord_.channelId
            .equals(channelId)
            .and(MessagelocalRecord_.timestamp > timestamp))
        .build()
        .find();
  }
}
