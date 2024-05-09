import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataBaseService {
  Future<String> createCollection({
    required String collection,
    required String documentID,
    required Map<String, dynamic> setOfValues,
  }) async {
    try{
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
      try{
      await FirebaseFirestore.instance
            .collection(collection)
            .doc(documentID)
            .update(setOfValues);
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }
}