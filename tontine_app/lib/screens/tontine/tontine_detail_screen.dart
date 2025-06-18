import 'package:flutter/material.dart';

class TontineDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Détails de la Tontine')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nom : Tontine Voyage', style: TextStyle(fontSize: 18)),
            Text('Montant : 30 €'),
            Text('Membres : 10'),
            Text('Périodicité : Mensuel'),
            Text('Date prochaine contribution : 01/07/2025'),
            Text('Mode de collecte : Automatique'),
            Text('Ordre de redistribution : Aléatoire'),
            Text('Prochain bénéficiaire : Awa'),
            Text('Contributions en cours : 2'),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('Relancer')),
                ElevatedButton(onPressed: () {}, child: Text('Modifier')),
                ElevatedButton(onPressed: () {}, child: Text('Contribuer')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
