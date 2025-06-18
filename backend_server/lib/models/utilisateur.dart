class Utilisateur {
  final String id;
  final String nom;
  final String phone;

  Utilisateur({required this.id, required this.nom, required this.phone});

  Map<String, dynamic> toMap() => {
    '_id': id,
    'nom': nom,
    'phone': phone,
  };

  static Utilisateur fromMap(Map<String, dynamic> map) => Utilisateur(
    id: map['_id'],
    nom: map['nom'],
    phone: map['phone'],
  );
}
