import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import 'invite_members_screen.dart';
import '../../services/api_service.dart';

class CreateTontineScreen extends StatefulWidget {
  @override
  _CreateTontineScreenState createState() => _CreateTontineScreenState();
}

class _CreateTontineScreenState extends State<CreateTontineScreen> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  double montant = 0;
  int membres = 0;
  String periodicite = 'Mensuel';
  String mode = 'Auto';
  String ordre = 'Défini';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Créer une tontine')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField('Nom de la tontine', (val) => name = val),
              _buildNumberField('Montant', (val) => montant = double.tryParse(val) ?? 0),
              _buildNumberField('Nombre de membres', (val) => membres = int.tryParse(val) ?? 0),
              _buildDropdown('Périodicité', ['Mensuel', 'Hebdomadaire'], (val) => periodicite = val!),
              _buildDropdown('Mode de collecte', ['Auto', 'Manuel'], (val) => mode = val!),
              _buildDropdown('Ordre de redistribution', ['Défini', 'Aléatoire'], (val) => ordre = val!),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                        final tontine = await ApiService.createTontine({
                        'nom': name,
                        'montant': montant,
                        'membres': membres,
                        'periodicite': periodicite,
                        'mode': mode,
                        'ordre': ordre,
                        'createurId': 'user123', // temporaire
                        });

                        if (tontine != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                            builder: (_) => InviteMembersScreen(tontineCode: tontine.id),
                            ),
                        );
                        } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la création')));
                        }
                    }
                    },
                child: Text('Créer la tontine'),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: (val) => val!.isEmpty ? 'Ce champ est requis' : null,
    );
  }

  Widget _buildNumberField(String label, Function(String) onChanged) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      onChanged: onChanged,
      validator: (val) => val!.isEmpty ? 'Ce champ est requis' : null,
    );
  }

  Widget _buildDropdown(String label, List<String> options, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      items: options.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      validator: (val) => val == null ? 'Veuillez choisir une valeur' : null,
    );
  }
}
