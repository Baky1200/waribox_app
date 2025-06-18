// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tontine.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tontine _$TontineFromJson(Map<String, dynamic> json) => Tontine(
  id: json['id'] as String,
  nom: json['nom'] as String,
  montant: (json['montant'] as num).toDouble(),
  membres: (json['membres'] as num).toInt(),
  periodicite: json['periodicite'] as String,
  mode: json['mode'] as String,
  ordre: json['ordre'] as String,
  createurId: json['createurId'] as String,
  invites: (json['invites'] as List<dynamic>).map((e) => e as String).toList(),
  prochaineDate: DateTime.parse(json['prochaineDate'] as String),
);

Map<String, dynamic> _$TontineToJson(Tontine instance) => <String, dynamic>{
  'id': instance.id,
  'nom': instance.nom,
  'montant': instance.montant,
  'membres': instance.membres,
  'periodicite': instance.periodicite,
  'mode': instance.mode,
  'ordre': instance.ordre,
  'createurId': instance.createurId,
  'invites': instance.invites,
  'prochaineDate': instance.prochaineDate.toIso8601String(),
};
