import 'dart:typed_data';

import 'package:objectbox/objectbox.dart';

import '../../../../objectbox.g.dart';

abstract class LocalData {
  int id;
  String channelId;
  int timestamp;
  Uint8List data;

  LocalData(
      {this.id = 0,
      required this.channelId,
      required this.data,
      int? timestamp})
      : timestamp = timestamp ?? DateTime.now().microsecondsSinceEpoch;
}

@Entity()
class ChannelLocalRecord extends LocalData {
  @Id()
  int id;
  @Unique()
  String channelId;
  @Property(type: PropertyType.dateNano)
  int timestamp;
  Uint8List data;

  ChannelLocalRecord({
    this.id = 0,
    required this.channelId,
    required this.data,
    required this.timestamp,
  }) : super(
          channelId: channelId,
          data: data,
          timestamp: timestamp,
        );
}

@Entity()
class MessagelocalRecord extends LocalData {
  @override
  @Id()
  int id;
  @override
  @Index()
  String channelId;
  @Property(type: PropertyType.dateNano)
  int timestamp;
  @override
  Uint8List data;

  MessagelocalRecord({
    this.id = 0,
    required this.channelId,
    required this.data,
    required this.timestamp,
  }) : super(
          channelId: channelId,
          data: data,
          timestamp: timestamp,
        );
}
