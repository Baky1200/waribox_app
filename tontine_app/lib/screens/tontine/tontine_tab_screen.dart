import 'package:flutter/material.dart';
import '../../models/tontine_model.dart';
import '../../widgets/tontine_card.dart';
import '../../routes/app_routes.dart';
import '../../services/api_service.dart'; // Assure-toi que ce fichier existe

class TontineTabScreen extends StatefulWidget {
  const TontineTabScreen({Key? key}) : super(key: key);

  @override
  _TontineTabScreenState createState() => _TontineTabScreenState();
}

class _TontineTabScreenState extends State<TontineTabScreen> {
  List<Tontine> tontines = [];

  @override
  void initState() {
    super.initState();
    _loadTontines();
  }

  Future<void> _loadTontines() async {
    try {
      final list = await ApiService.getTontinesByUser('user123');
      setState(() {
        tontines = (list as List).map((json) => Tontine.fromJson(json as Map<String, dynamic>)).toList();
      });
    } catch (e) {
      print('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes Tontines')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tontines.length,
              itemBuilder: (context, index) {
                return TontineCard(
                  tontine: tontines[index],
                  onTap: () => Navigator.pushNamed(context, AppRoutes.tontineDetail),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Créer une tontine"),
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.createTontine),
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.login),
                  label: Text("Rejoindre une tontine"),
                  onPressed: () => Navigator.pushNamed(context, AppRoutes.joinTontine),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
