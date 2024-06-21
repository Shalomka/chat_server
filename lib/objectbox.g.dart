// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;

import 'src/features/local_storage/models/models.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
      id: const obx_int.IdUid(5, 9060223726500477681),
      name: 'ChannelLocalRecord',
      lastPropertyId: const obx_int.IdUid(4, 8836211994987388335),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 8845262780508194024),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 273617467844882216),
            name: 'channelId',
            type: 9,
            flags: 2080,
            indexId: const obx_int.IdUid(5, 6881432812060284214)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 5495839111920624479),
            name: 'timestamp',
            type: 12,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 8836211994987388335),
            name: 'data',
            type: 23,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[]),
  obx_int.ModelEntity(
      id: const obx_int.IdUid(6, 4249193164464264394),
      name: 'MessagelocalRecord',
      lastPropertyId: const obx_int.IdUid(4, 881028309144572907),
      flags: 0,
      properties: <obx_int.ModelProperty>[
        obx_int.ModelProperty(
            id: const obx_int.IdUid(1, 1970616167812968881),
            name: 'id',
            type: 6,
            flags: 1),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(2, 7517646778983956860),
            name: 'channelId',
            type: 9,
            flags: 2048,
            indexId: const obx_int.IdUid(6, 7233380198140888228)),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(3, 4831410946380638063),
            name: 'timestamp',
            type: 12,
            flags: 0),
        obx_int.ModelProperty(
            id: const obx_int.IdUid(4, 881028309144572907),
            name: 'data',
            type: 23,
            flags: 0)
      ],
      relations: <obx_int.ModelRelation>[],
      backlinks: <obx_int.ModelBacklink>[])
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
obx.Store openStore(
    {String? directory,
    int? maxDBSizeInKB,
    int? maxDataSizeInKB,
    int? fileMode,
    int? maxReaders,
    bool queriesCaseSensitiveDefault = true,
    String? macosApplicationGroup}) {
  return obx.Store(getObjectBoxModel(),
      directory: directory,
      maxDBSizeInKB: maxDBSizeInKB,
      maxDataSizeInKB: maxDataSizeInKB,
      fileMode: fileMode,
      maxReaders: maxReaders,
      queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
      macosApplicationGroup: macosApplicationGroup);
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
      entities: _entities,
      lastEntityId: const obx_int.IdUid(6, 4249193164464264394),
      lastIndexId: const obx_int.IdUid(6, 7233380198140888228),
      lastRelationId: const obx_int.IdUid(0, 0),
      lastSequenceId: const obx_int.IdUid(0, 0),
      retiredEntityUids: const [
        8413413419130829509,
        8034757944374133803,
        3341015250815377313,
        59751018632740534
      ],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        8123495950453700346,
        7912813797121365019,
        6315226484850152709,
        1720196292513917091,
        54616515789177163,
        8243288982738126533,
        2909541232412066367,
        7947658874344960260,
        6402464154058864451,
        3147076253131563386,
        7775390555691953694,
        6642941059040373440,
        8881258117332028317,
        4267921778780368612,
        7814792062381857520,
        400890246474709854
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, obx_int.EntityDefinition>{
    ChannelLocalRecord: obx_int.EntityDefinition<ChannelLocalRecord>(
        model: _entities[0],
        toOneRelations: (ChannelLocalRecord object) => [],
        toManyRelations: (ChannelLocalRecord object) => {},
        getId: (ChannelLocalRecord object) => object.id,
        setId: (ChannelLocalRecord object, int id) {
          object.id = id;
        },
        objectToFB: (ChannelLocalRecord object, fb.Builder fbb) {
          final channelIdOffset = fbb.writeString(object.channelId);
          final dataOffset = fbb.writeListInt8(object.data);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, channelIdOffset);
          fbb.addInt64(2, object.timestamp);
          fbb.addOffset(3, dataOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final channelIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final dataParam = const fb.Uint8ListReader(lazy: false)
              .vTableGet(buffer, rootOffset, 10, Uint8List(0)) as Uint8List;
          final timestampParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final object = ChannelLocalRecord(
              id: idParam,
              channelId: channelIdParam,
              data: dataParam,
              timestamp: timestampParam);

          return object;
        }),
    MessagelocalRecord: obx_int.EntityDefinition<MessagelocalRecord>(
        model: _entities[1],
        toOneRelations: (MessagelocalRecord object) => [],
        toManyRelations: (MessagelocalRecord object) => {},
        getId: (MessagelocalRecord object) => object.id,
        setId: (MessagelocalRecord object, int id) {
          object.id = id;
        },
        objectToFB: (MessagelocalRecord object, fb.Builder fbb) {
          final channelIdOffset = fbb.writeString(object.channelId);
          final dataOffset = fbb.writeListInt8(object.data);
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, channelIdOffset);
          fbb.addInt64(2, object.timestamp);
          fbb.addOffset(3, dataOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (obx.Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final idParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0);
          final channelIdParam = const fb.StringReader(asciiOptimization: true)
              .vTableGet(buffer, rootOffset, 6, '');
          final dataParam = const fb.Uint8ListReader(lazy: false)
              .vTableGet(buffer, rootOffset, 10, Uint8List(0)) as Uint8List;
          final timestampParam =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          final object = MessagelocalRecord(
              id: idParam,
              channelId: channelIdParam,
              data: dataParam,
              timestamp: timestampParam);

          return object;
        })
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [ChannelLocalRecord] entity fields to define ObjectBox queries.
class ChannelLocalRecord_ {
  /// See [ChannelLocalRecord.id].
  static final id =
      obx.QueryIntegerProperty<ChannelLocalRecord>(_entities[0].properties[0]);

  /// See [ChannelLocalRecord.channelId].
  static final channelId =
      obx.QueryStringProperty<ChannelLocalRecord>(_entities[0].properties[1]);

  /// See [ChannelLocalRecord.timestamp].
  static final timestamp =
      obx.QueryDateNanoProperty<ChannelLocalRecord>(_entities[0].properties[2]);

  /// See [ChannelLocalRecord.data].
  static final data = obx.QueryByteVectorProperty<ChannelLocalRecord>(
      _entities[0].properties[3]);
}

/// [MessagelocalRecord] entity fields to define ObjectBox queries.
class MessagelocalRecord_ {
  /// See [MessagelocalRecord.id].
  static final id =
      obx.QueryIntegerProperty<MessagelocalRecord>(_entities[1].properties[0]);

  /// See [MessagelocalRecord.channelId].
  static final channelId =
      obx.QueryStringProperty<MessagelocalRecord>(_entities[1].properties[1]);

  /// See [MessagelocalRecord.timestamp].
  static final timestamp =
      obx.QueryDateNanoProperty<MessagelocalRecord>(_entities[1].properties[2]);

  /// See [MessagelocalRecord.data].
  static final data = obx.QueryByteVectorProperty<MessagelocalRecord>(
      _entities[1].properties[3]);
}
