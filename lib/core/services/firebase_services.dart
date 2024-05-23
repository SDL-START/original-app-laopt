

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

abstract class FirebaseFireStore {
  Stream<QuerySnapshot<Map<String, dynamic>>> receiveMessage({required String collection});
}

@lazySingleton
class FirebaseServices extends FirebaseFireStore{
  final FirebaseFirestore firestore;
  FirebaseServices(this.firestore);
  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> receiveMessage({required String collection}) {
    return firestore.collection(collection).snapshots();
  }
}