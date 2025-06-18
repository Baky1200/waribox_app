import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

import '../models/tontine.dart';
import '../database/mongo_service.dart';

class TontineRoutes {
  Handler get handler {
    final router = Router();

    // Créer une nouvelle tontine
    router.post('/tontine', (Request request) async {
      final payload = await request.readAsString();
      final data = jsonDecode(payload);
      final id = const Uuid().v4();

      final tontine = {
        '_id': id,
        'nom': data['nom'],
        'montant': data['montant'],
        'membres': data['membres'],
        'periodicite': data['periodicite'],
        'mode': data['mode'],
        'ordre': data['ordre'],
        'createurId': data['createurId'],
        'invites': <String>[],
        'prochaineDate': DateTime.now().toIso8601String(),
        'createdAt': DateTime.now().toIso8601String(),
      };

      await MongoService.tontines.insertOne(tontine);
      return Response.ok(jsonEncode(tontine), headers: {'Content-Type': 'application/json'});
    });

    // Obtenir les tontines d'un utilisateur
    router.get('/tontines/<userId>', (Request request, String userId) async {
      final list = await MongoService.tontines.find({'createurId': userId}).toList();
      return Response.ok(jsonEncode(list), headers: {'Content-Type': 'application/json'});
    });

    // Inviter un utilisateur à une tontine
    router.post('/tontine/inviter/<id>', (Request request, String id) async {
      final data = jsonDecode(await request.readAsString());
      final phone = data['phone'];

      final exists = await MongoService.utilisateurs.findOne({'phone': phone});
      if (exists == null) return Response.notFound('Utilisateur non trouvé');

      final update = await MongoService.tontines.updateOne(
        where.eq('_id', id),
        modify.push('invites', phone),
      );

      if (update.isSuccess) {
        return Response.ok(jsonEncode({'message': 'Utilisateur invité'}));
      } else {
        return Response.internalServerError(body: 'Erreur d\'invitation');
      }
    });

// Rejoindre une tontine
    router.post('/tontine/rejoindre/<id>', (Request request, String id) async {
      final data = jsonDecode(await request.readAsString());
      final phone = data['phone'];

      final tontine = await MongoService.tontines.findOne({'_id': id});
      if (tontine == null) return Response.notFound('Tontine introuvable');

      final invited = (tontine['invites'] as List).contains(phone);
      if (!invited) return Response.forbidden('Non invité à cette tontine');

      await MongoService.tontines.updateOne(
        where.eq('_id', id),
        modify.pull('invites', phone).push('participants', phone),
      );



      // Mise à jour avec $push pour ajouter un numéro à la liste d'invités
      await MongoService.tontines.updateOne(
        {'_id': id},
        {
          r'$push': {'invites': phone}
        },
      );

      return Response.ok(jsonEncode({'message': 'Inscription confirmée'}));
    });

    return router;
  }
}
