import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DataBaseService {
  Future<String> createCollection({
    required String collection,
    required String documentID,
    required Map<String, dynamic> setOfValues,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentID)
          .set(setOfValues);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateDocument({
    required String collection,
    required String documentID,
    required Map<String, dynamic> setOfValues,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentID)
          .update(setOfValues);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<Map<String, dynamic>>> fetchDocuments({
    required String collection,
  }) async {
    List<Map<String, dynamic>> docs = [];

    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collection).get();

      querySnapshot.docs.forEach((doc) {
        String name = doc.id;
        dynamic bannerImage =
            doc.get('Banner_Image'); // Retrieve the Banner_Image field

        // Create a map containing document name and Banner_Image value
        Map<String, dynamic> docMap = {
          'name': name,
          'bannerImage': bannerImage,
        };

        docs.add(docMap);
      });
    } catch (error) {
      print("Error fetching categories: $error");
      return [];
    }

    return docs;
  }

  Future<Map<String, dynamic>> fetchData({
    required String collection,
    required String documentID,
  }) async {
    
      try{
        DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection(collection)
          .doc(documentID)
          .get();
      Map<String, dynamic> data = (snap.data()! as dynamic);

      // print(data);
      return data;
      }catch(e) {
        Map<String, dynamic> d = {};
        return d;
      }
   
  }
}
