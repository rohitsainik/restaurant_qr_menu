import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/menu_style_model.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:qr_menu/utils/model_keys.dart';

class MenuStyleScreen extends StatefulWidget {
  const MenuStyleScreen({Key? key}) : super(key: key);

  @override
  _MenuStyleScreenState createState() => _MenuStyleScreenState();
}

class _MenuStyleScreenState extends State<MenuStyleScreen> {
  int? selectedIndex;

  List<MenuStyleModel> data = MenuStyleModel.getStyleList();

  String lastMenuStyle = getStringAsync(SharePreferencesKey.MENU_STYLE);

  @override
  void initState() {
    selectedIndex = data.indexWhere(
        (element) => element.styleName == appStore.selectedMenuStyle);
    super.initState();
  }

  Future<void> onMenuClick(String menuStyle) async {
    bool isAllRestaurantsUpdated = true;
    setMenuStyle(menuStyle);

    appStore.setLoading(true);

    await restaurantOwnerService
        .getRestaurantListFuture()
        .then((resList) async {
      await Future.forEach<RestaurantModel>(resList, (element) async {
        Map<String, dynamic> data = {
          CommonKeys.updatedAt: Timestamp.now(),
          Restaurants.menuStyle: menuStyle,
        };

        selectedRestaurant.menuStyle = menuStyle;

        await restaurantOwnerService
            .updateDocument(data, element.uid)
            .then((_) {
          //
        }).catchError((e) {
          log(e);
          isAllRestaurantsUpdated = false;
        });
      });
    }).catchError((e) {
      isAllRestaurantsUpdated = false;
      toast(e.toString());
    });

    if (!isAllRestaurantsUpdated) {
      setMenuStyle(lastMenuStyle);
    }

    appStore.setLoading(false);
  }

  setMenuStyle(String menuStyle) {
    setValue(SharePreferencesKey.MENU_STYLE, menuStyle);
    appStore.setMenuStyle(menuStyle);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: appBarWidget(
          language.lblSetMenuStyle,
          showBack: true,
          elevation: 0,
          color: context.scaffoldBackgroundColor,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: List.generate(data.length, (index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: radius(defaultRadius),
                  color: index == selectedIndex
                      ? (appStore.isDarkMode
                          ? Colors.white54
                          : primaryColor.withAlpha(40))
                      : context.cardColor,
                  border: Border.all(color: context.dividerColor),
                ),
                width: context.width() / 2 - 24,
                padding: EdgeInsets.all(16),
                child: Text('${data[index].styleName}', style: boldTextStyle()),
              ).onTap(() {
/*              selectedIndex = index;
                appStore.setMenuStyle(data[index].styleName.validate());
                setValue(SharePreferencesKey.MENU_STYLE, data[index].styleName);
                setState(() {});*/
                selectedIndex = index;
                onMenuClick(data[index].styleName.validate());
                setState(() {});
              }, borderRadius: radius(defaultRadius));
            }),
          ),
        ),
      ),
    );
  }
}
