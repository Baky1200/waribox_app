import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tontine_model.dart';
import '../models/utilisateur_model.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080'; // Sur mobile, remplacer par l'IP locale

  static Future<Tontine?> createTontine(Map<String, dynamic> data) async {
    final url = Uri.parse('$baseUrl/tontine');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return Tontine.fromJson(jsonDecode(response.body));
    } else {
      print('Erreur création: ${response.body}');
      return null;
    }
  }

  // Créer ou récupérer un utilisateur
  static Future<Utilisateur?> getOrCreateUser(String nom, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/utilisateur'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nom': nom, 'phone': phone}),
    );

    if (response.statusCode == 200) {
      return Utilisateur.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // Inviter un utilisateur
  static Future<bool> inviterUtilisateur(String tontineId, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tontine/inviter/$tontineId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );

    return response.statusCode == 200;
  }

  static Future<List<Tontine>> getTontinesByUser(String userId) async {
    final url = Uri.parse('$baseUrl/tontines/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Tontine.fromJson(json)).toList();
    } else {
      throw Exception('Erreur de chargement des tontines');
    }
  }

  // Rejoindre une tontine
  static Future<bool> rejoindreTontine(String tontineId, String phone) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tontine/rejoindre/$tontineId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );

    return response.statusCode == 200;
  }
}
