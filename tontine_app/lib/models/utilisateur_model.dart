class Utilisateur {
  final String id;
  final String nom;
  final String phone;

  Utilisateur({
    required this.id,
    required this.nom,
    required this.phone,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      id: json['_id'],
      nom: json['nom'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'nom': nom,
    'phone': phone,
  };
}
