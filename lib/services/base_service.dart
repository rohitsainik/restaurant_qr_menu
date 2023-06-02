import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';

FirebaseStorage _storage = FirebaseStorage.instance;

abstract class BaseService<T> {
  CollectionReference<T>? ref;

  BaseService({this.ref});

  Future<DocumentReference> addDocument(T data) async {
    var doc = await ref!.add(data);
    doc.update({'uid': doc.id});
    return doc;
  }

  Future<DocumentReference> addDocumentWithCustomId(String id, T data) async {
    var doc = ref!.doc(id);

    return await doc.set(data).then((value) {
      return doc;
    }).catchError((e) {
      log(e);
      throw e;
    });
  }

  Future<void> updateDocument(Map<String, dynamic> data, String? id) =>
      ref!.doc(id).update(data);

  Future<void> removeDocument(String id) => ref!.doc(id).delete();

  Future<bool> isUserExist(String? email) async {
    Query query = ref!.limit(1).where('email', isEqualTo: email);
    var res = await query.get();

    if (res.docs.isNotEmpty) {
      return res.docs.length == 1;
    } else {
      return false;
    }
  }

  Future<Iterable> getList() async {
    var res = await ref!.get();
    Iterable it = res.docs;
    return it;
  }

  static Future<String> getUploadedImageURL(XFile image, String path) async {
    String fileName = path;
    Reference storageRef = _storage.ref().child("$path/$fileName");
    UploadTask uploadTask;
    if (isWeb) {
      Uint8List bytes = await image.readAsBytes();
      uploadTask = storageRef.putData(bytes);
    } else {
      uploadTask = storageRef.putFile(File(image.path));
    }
    return await uploadTask.then((e) async {
      return await e.ref.getDownloadURL().then((value) {
        return value;
      });
    });
  }
}
