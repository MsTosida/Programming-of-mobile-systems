import 'package:cloud_firestore/cloud_firestore.dart';
import 'bakery.dart';

const String BAKERY_COLLECTION_REF = "bakery";

class DatabaseService{
    final _firestore = FirebaseFirestore.instance;

    late final CollectionReference _bakeryRef;

    DatabaseService(){
    _bakeryRef = _firestore.collection(BAKERY_COLLECTION_REF).withConverter<Bakery>(
      fromFirestore: (snapshots, _)=> Bakery.fromJson(snapshots.data()!,),
      toFirestore: (bak, _) => bak.toJson()
  );
}

    Stream<QuerySnapshot> getBakeries(){
      return _bakeryRef.snapshots();
    }


    void addBakery(Bakery bak) async{
      _bakeryRef.add(bak);
    }

    void updateBakery(String bakId, Bakery bak) async{
      _bakeryRef.doc(bakId).update(bak.toJson());
    }

    void deleteBakery(String bakId) async{
      _bakeryRef.doc(bakId).delete();
    }
}