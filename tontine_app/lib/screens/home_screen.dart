import 'package:flutter/material.dart';
import 'navigation_root.dart';

class HomeScreen extends StatelessWidget {
  void _navigateToTab(BuildContext context, int index) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavigationRoot(initialIndex: index)),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required int tabIndex,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(icon, size: 40, color: Colors.teal),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () => _navigateToTab(context, tabIndex),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenue sur ton espace Waribox'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bonjour 👋', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            _buildServiceCard(
              context: context,
              title: 'Tontine',
              description: 'Épargne en groupe avec des contributions régulières et bénéficie de la cagnotte à tour de rôle.',
              icon: Icons.groups,
              tabIndex: 1,
            ),
            _buildServiceCard(
              context: context,
              title: 'Coffre Collectif',
              description: 'Constitue une épargne collective avec tes proches et collaborateurs pour vos projets communs.',
              icon: Icons.savings,
              tabIndex: 2,
            ),
            _buildServiceCard(
              context: context,
              title: 'Coffre Individuel',
              description: 'Souscris à un coffre individuel et gère ton épargne selon tes objectifs personnels.',
              icon: Icons.lock,
              tabIndex: 3,
            ),
          ],
        ),
      ),
    );
  }
}
