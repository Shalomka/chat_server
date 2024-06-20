import 'package:chat_proto/chat_proto.dart';
import 'package:chat_server/chat_server.dart';

import 'dart:async';

import 'package:chat_server/objectbox.g.dart';

void main(List<String> arguments) async {
  final int port = 8080;

  final Store store = openStore();
  // final auth = AuthInterceptor();
  // final db = DatabaseConnection();

  // await db.connect();

  final chatService = ChatService(store);

  ///
  /// Services
  ///
  final services = [
    chatService,
  ];

  ///
  /// Interceptors
  ///
  final interceptors = <FutureOr<GrpcError?> Function(
      ServiceCall, ServiceMethod<dynamic, dynamic>)>[
    //loggingInterceptor,
    //auth.intercept,
  ];

  ///
  /// Start the server!
  ///
  final server = Server.create(services: services, interceptors: interceptors);
  await server.serve(port: port);
  print('Server listening on port $port');
}
