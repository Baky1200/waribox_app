import 'package:json_annotation/json_annotation.dart';

part 'tontine.g.dart';

@JsonSerializable()
class Tontine {
  final String id;
  final String nom;
  final double montant;
  final int membres;
  final String periodicite;
  final String mode;
  final String ordre;
  final String createurId;
  final List<String> invites;
  final DateTime prochaineDate;

  // Facultatif : généré dynamiquement si besoin dans le code métier
  String get prochainBeneficiaire =>
      invites.isNotEmpty ? invites.first : '';

  int get contributions => invites.length;

  Tontine({
    required this.id,
    required this.nom,
    required this.montant,
    required this.membres,
    required this.periodicite,
    required this.mode,
    required this.ordre,
    required this.createurId,
    required this.invites,
    required this.prochaineDate,
  });

  factory Tontine.fromJson(Map<String, dynamic> json) =>
      _$TontineFromJson(json);

  Map<String, dynamic> toJson() => _$TontineToJson(this);
}
