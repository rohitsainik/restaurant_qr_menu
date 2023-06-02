import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/models/menu_category_model.dart';
import 'package:qr_menu/models/menu_model.dart';

part 'menu_store.g.dart';

class MenuStore = MenuStoreBase with _$MenuStore;

abstract class MenuStoreBase with Store {
  @observable
  CategoryModel? selectedCategoryData;

  @action
  void setSelectedCategoryData(CategoryModel? val) async {
    selectedCategoryData = val;

    appStore.setLoading(true);
    if (val != null) {
      List<MenuModel> list =
          await menuService.getAllDataCategoryWiseFuture(categoryId: val.uid);

      List<MenuCategoryModel> menus = [];
      list.forEach((element) {
        List<MenuModel> temp = list
            .where((e) => e.categoryId == element.categoryId.validate())
            .toList();
        menus
            .add(MenuCategoryModel(categoryId: element.categoryId, menu: temp));
      });

      appStore.setMenuByCategoryList(menus);
    } else {
      List<MenuModel> list =
          await menuService.getMenuDataFuture().catchError((e) {
        log(e.toString());
      });
      List<MenuCategoryModel> menus = [];
      await Future.forEach<MenuModel>(list, (menu) {
        if (menus.isNotEmpty) {
          if (menus.every(
              (e) => menu.categoryId.validate() != e.categoryId.validate())) {
            List<MenuModel> temp = list
                .where((e) => e.categoryId == menu.categoryId.validate())
                .toList();
            menus.add(
                MenuCategoryModel(categoryId: menu.categoryId, menu: temp));
          }
        } else {
          List<MenuModel> temp = list
              .where((e) => e.categoryId == menu.categoryId.validate())
              .toList();
          menus.add(MenuCategoryModel(categoryId: menu.categoryId, menu: temp));
        }
      });
      appStore.setMenuByCategoryList(menus);
    }
    appStore.setLoading(false);
  }
}
