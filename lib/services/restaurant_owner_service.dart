import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:qr_menu/utils/model_keys.dart';

import 'base_service.dart';

class RestaurantOwnerService extends BaseService<RestaurantModel> {
  RestaurantOwnerService() {
    ref = fireStore
        .collection(Collections.restaurants)
        .withConverter<RestaurantModel>(
          fromFirestore: (snapshot, options) =>
              RestaurantModel.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  Stream<List<RestaurantModel>> getRestaurantData() {
    return ref!
        .where(Restaurants.userId,
            isEqualTo: getStringAsync(SharePreferencesKey.USER_ID))
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<RestaurantModel> getRestaurantFutureData(String? id) async {
    return ref!
        .limit(1)
        .where(CommonKeys.id, isEqualTo: id)
        .get()
        .then((value) => value.docs.first.data());
  }

  Future<List<RestaurantModel>> getRestaurantListFuture() {
    return ref!
        .where(Restaurants.userId,
            isEqualTo: getStringAsync(SharePreferencesKey.USER_ID))
        .get()
        .then((event) => event.docs.map((e) => e.data()).toList());
  }

  Future<String> addResturantInfo(Map<String, dynamic> data,
      {XFile? profileImage, XFile? logoImage}) async {
    var doc = await ref!.add(RestaurantModel.fromJson(data));
    ref!.doc(doc.id).update({CommonKeys.id: doc.id});

    if (profileImage != null) {
      ref!.doc(doc.id).update({
        Restaurants.image:
            await BaseService.getUploadedImageURL(profileImage, doc.id)
      });
    }
    if (logoImage != null) {
      ref!.doc(doc.id).update({
        Restaurants.logoImage:
            await BaseService.getUploadedImageURL(logoImage, "Logo${doc.id}")
      });
    }
    return doc.id;
  }

  Future<void> updateResturantInfo(Map<String, dynamic> data, String id,
      {XFile? profileImage, XFile? logoImage}) async {
    await ref!.doc(id).update(data);
    if (profileImage != null) {
      ref!.doc(id).update({
        Restaurants.image:
            await BaseService.getUploadedImageURL(profileImage, id)
      });
    }
    if (logoImage != null) {
      ref!.doc(id).update({
        Restaurants.logoImage:
            await BaseService.getUploadedImageURL(logoImage, "Logo$id")
      });
    }
    return;
  }

  Stream<int> getLength() {
    return ref!
        .where(Restaurants.userId,
            isEqualTo: getStringAsync(SharePreferencesKey.USER_ID))
        .snapshots()
        .map((event) => event.docs.length);
  }

  Future<void> removeCustomDocument(String id) async {
    Future<QuerySnapshot> menus =
        ref!.doc(id).collection(Collections.menus).get();
    menus.then((value) {
      value.docs.forEach((element) {
        fireStore
            .collection(Collections.restaurants)
            .doc(id)
            .collection(Collections.menus)
            .doc(element.id)
            .delete();
      });
    });

    Future<QuerySnapshot> categories =
        ref!.doc(id).collection(Collections.categories).get();
    categories.then((value) {
      value.docs.forEach((element) {
        ref!
            .doc(id)
            .collection(Collections.categories)
            .doc(element.id)
            .delete()
            .then((value) async {});
      });
    });

    await ref!.doc(id).delete();
  }
}
