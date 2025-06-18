import 'package:flutter/material.dart';
import '../../services/api_service.dart';

class JoinTontineScreen extends StatefulWidget {
  @override
  _JoinTontineScreenState createState() => _JoinTontineScreenState();
}

class _JoinTontineScreenState extends State<JoinTontineScreen> {
  final codeController = TextEditingController();
  final phoneController = TextEditingController();

  void _joinTontine() async {
    final code = codeController.text.trim();
    final phone = phoneController.text.trim();

    final success = await ApiService.rejoindreTontine(code, phone);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vous avez rejoint la tontine")),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Échec : code invalide ou non invité")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rejoindre une Tontine')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(labelText: 'Code de la tontine'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Votre numéro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _joinTontine,
              child: Text('Rejoindre'),
            )
          ],
        ),
      ),
    );
  }
}