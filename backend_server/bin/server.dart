import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

import '../lib/database/mongo_service.dart';
import '../lib/routes/tontine_routes.dart';
import '../lib/routes/user_routes.dart';

void main() async {

  await MongoService.connect(); // ⬅️ Connexion à MongoDB

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(
        Cascade()
            .add(UserRoutes().handler)
            .add(TontineRoutes().handler)
            .handler,
  );

  final server = await serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Serveur lancé sur http://${server.address.host}:${server.port}');
}
