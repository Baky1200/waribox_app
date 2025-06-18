import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../services/api_service.dart';

class InviteMembersScreen extends StatefulWidget {
  final String tontineCode; // reçu depuis la création de la tontine

  InviteMembersScreen({required this.tontineCode});

  @override
  _InviteMembersScreenState createState() => _InviteMembersScreenState();
}

class _InviteMembersScreenState extends State<InviteMembersScreen> {
  final List<String> members = [];
  final TextEditingController phoneController = TextEditingController();

  void addMember() {
    final phone = phoneController.text.trim();
    if (phone.isNotEmpty && !members.contains(phone)) {
      setState(() {
        members.add(phone);
        phoneController.clear();
      });
    }
  }

  void copyInviteLink() {
    final link = 'https://waribox.app/invite/${widget.tontineCode}';
    Clipboard.setData(ClipboardData(text: link));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Lien copié dans le presse-papiers !")),
    );
  }

  void submitInvitations() {
    // TODO: Envoyer les invitations via API
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Invitations envoyées à ${members.length} personnes")),
    );
    Navigator.pop(context); // Retour à l'écran précédent
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Inviter des membres')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Ajoute des membres à ta tontine', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Numéro de téléphone',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: addMember,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(members[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() => members.removeAt(index));
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: copyInviteLink,
              icon: Icon(Icons.link),
              label: Text('Copier lien d’invitation'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                for (var phone in members) {
                  await ApiService.inviterUtilisateur(widget.tontineCode, phone);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Invitations envoyées !')),
                );
                Navigator.pop(context);
              }              ,
              child: Text('Envoyer les invitations'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
