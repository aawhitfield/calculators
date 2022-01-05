import 'package:calculators/models/brrrr.dart';
import 'package:calculators/models/calculator.dart';
import 'package:calculators/models/quick_max_offer.dart';
import 'package:calculators/providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DatabaseUtils {
  static Future<void> deletePlaceByID(String id) async{

    await FirebaseFirestore.instance.collection(FirestoreCollections.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FirestoreCollections.calculators)
        .doc(id)
        .delete();

    return;
  }

  static Future<Calculator> loadDataByID(String id, WidgetRef ref, Calculator calculatorType) async {
    // download data from Firestore
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance.collection(FirestoreCollections.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(FirestoreCollections.calculators)
        .doc(id)
        .get();

    if (documentSnapshot.data() != null) {
      Map<String, dynamic> data = documentSnapshot.data()!;
      if(calculatorType == Calculator.brrrr) {
        BRRRR brrrrData = BRRRR.fromJson(data);
        ref.read(brrrrProvider).updateAll(brrrrData);
      }
      else if(calculatorType == Calculator.quickMaxOffer) {
        QuickMaxOffer quickMaxOfferData = QuickMaxOffer.fromJson(data);
        ref.read(quickMaxProvider).updateAll(quickMaxOfferData);
        ref.read(quickMaxProvider).calculateAllQuickMaxOffer();
      }
    }
    return calculatorType;
  }

  static Future<void> saveDataToDatabase({required String uid, String? docID, required Map<String, dynamic> data}) async {

    await FirebaseFirestore.instance.collection('users').doc(uid)
      .collection('calculators')
      .doc((docID))
      .set(data, SetOptions(merge: true));



  }
}

class FirestoreCollections {
  static const String users = 'users';
  static const String calculators = 'calculators';
}