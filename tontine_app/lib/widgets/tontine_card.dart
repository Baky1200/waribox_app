import 'package:flutter/material.dart';
import '../models/tontine_model.dart';

class TontineCard extends StatelessWidget {
  final Tontine tontine;
  final VoidCallback onTap;

  TontineCard({required this.tontine, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tontine.nom, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.euro, size: 16), Text(' ${tontine.montant}  |  '),
                  Icon(Icons.group, size: 16), Text(' ${tontine.membres} pers  |  '),
                  Icon(Icons.calendar_today, size: 16),
                  Text(' ${tontine.prochaineDate.toString().split(' ')[0]}'),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 16),
                  SizedBox(width: 5),
                  Text("Détail", style: TextStyle(color: Colors.teal)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
