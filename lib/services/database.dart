import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({ required this.uid });


  final CollectionReference appCollection =
      FirebaseFirestore.instance.collection('app');

  Future updateUserData(String sugars, String name, int strength) async {
    return await appCollection.doc(uid).set({
      'sugars' : sugars,
      'name' : name,
      'strength' : strength,
    });
  }

  
}
