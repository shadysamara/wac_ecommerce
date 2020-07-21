import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String documentId;
  String userId;
  Order({
    this.userId,
    this.documentId,
  });
  Order.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    this.documentId = documentSnapshot.documentID;

    this.userId = documentSnapshot.data['userId'];
  }
  toJson() {
    return {'productId': this.documentId, 'userId': this.userId};
  }
}
