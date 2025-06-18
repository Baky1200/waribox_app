import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

import '../database/mongo_service.dart';

class UserRoutes {
  Handler get handler {
    final router = Router();

    // Créer ou récupérer un utilisateur
    router.post('/utilisateur', (Request request) async {
      final body = await request.readAsString();
      final data = jsonDecode(body);

      final existing = await MongoService.utilisateurs.findOne({'phone': data['phone']});
      if (existing != null) {
        return Response.ok(jsonEncode(existing));
      }

      final user = {
        '_id': const Uuid().v4(),
        'nom': data['nom'],
        'phone': data['phone'],
      };

      await MongoService.utilisateurs.insertOne(user);
      return Response.ok(jsonEncode(user));
    });

    return router;
  }
}
