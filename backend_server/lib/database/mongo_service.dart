import 'package:mongo_dart/mongo_dart.dart';

class MongoService {
  static Db? _db;
  static late DbCollection tontines;

  static Future<void> connect() async {
    const uri = 'mongodb://localhost:27017/waribox'; // ou URI MongoDB Atlas
    _db = await Db.create(uri);
    await _db!.open();
    tontines = _db!.collection('tontines');
    utilisateurs = _db!.collection('utilisateurs');
    print("✅ Connecté à MongoDB");
  }

  static Future<void> disconnect() async {
    await _db?.close();
  }
}
