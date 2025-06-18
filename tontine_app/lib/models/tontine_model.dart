class Tontine {
  final String id;
  final String nom;
  final double montant;
  final int membres;
  final DateTime prochaineDate;
  final String mode;
  final String ordre;
  final String prochainBeneficiaire;
  final int contributions;

  Tontine({
    required this.id,
    required this.nom,
    required this.montant,
    required this.membres,
    required this.prochaineDate,
    required this.mode,
    required this.ordre,
    required this.prochainBeneficiaire,
    required this.contributions,
  });

  factory Tontine.fromJson(Map<String, dynamic> json) {
    return Tontine(
      id: json['_id'] ?? json['id'] ?? '',
      nom: json['nom'] ?? '',
      montant: (json['montant'] as num).toDouble(),
      membres: json['membres'] ?? 0,
      prochaineDate: DateTime.parse(json['prochaineDate'] ?? DateTime.now().toIso8601String()),
      mode: json['mode'] ?? '',
      ordre: json['ordre'] ?? '',
      prochainBeneficiaire: json['prochainBeneficiaire'] ?? '',
      contributions: json['contributions'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'montant': montant,
      'membres': membres,
      'prochaineDate': prochaineDate.toIso8601String(),
      'mode': mode,
      'ordre': ordre,
      'prochainBeneficiaire': prochainBeneficiaire,
      'contributions': contributions,
    };
  }
}
