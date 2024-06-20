import 'package:chat_server/objectbox.g.dart';
import 'package:chat_server/src/features/local_storage/models/models.dart';
import 'package:chat_server/src/features/local_storage/services/local_data_repo.dart';

class ChannelsRepo extends LocalDataRepo<ChannelLocalRecord> {
  ChannelsRepo(super.store);

  // get channel by id
  Future<ChannelLocalRecord?> getChannelById(String channelId) async {
    return box
        .query(ChannelLocalRecord_.channelId.equals(channelId))
        .build()
        .findFirst();
  }

  // remove channel by id
  Future<int> removeChannelById(String channelId) async {
    return box
        .query(ChannelLocalRecord_.channelId.equals(channelId))
        .build()
        .remove();
  }

  // get channels after a timestamp
  Future<List<ChannelLocalRecord>> getChannelsAfterTimestamp(
      int timestamp) async {
    return box.query(ChannelLocalRecord_.timestamp > timestamp).build().find();
  }
}
