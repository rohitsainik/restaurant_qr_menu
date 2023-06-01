import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/models/menu_category_model.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/ui/menu/add_menu_item_screen.dart';
import 'package:qr_menu/ui/menu/menuStyle/menu_component_style_one.dart';
import 'package:qr_menu/ui/menu/menuStyle/menu_component_style_three.dart';
import 'package:qr_menu/ui/menu/menuStyle/menu_component_style_two.dart';
import 'package:qr_menu/ui/menu/menuStyle/menu_list_category_component.dart';
import 'package:qr_menu/ui/menu/menuStyle/menu_list_category_component_style_three.dart';
import 'package:qr_menu/ui/menu/menuStyle/menu_list_category_component_style_two.dart';
import 'package:qr_menu/ui/qr/qrStyle/qr_component_style_one.dart';
import 'package:qr_menu/ui/qr/qrStyle/qr_component_style_three.dart';
import 'package:qr_menu/ui/qr/qrStyle/qr_component_style_two.dart';

Widget getCategoryTextWidget(int length) {
  if (appStore.selectedMenuStyle == language.lblMenuStyle2) {
    return Stack(
      children: [
        Container(
          transform: new Matrix4.identity()..rotateZ(2 * 3.14 / 180),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(border: Border.all(color: appStore.isDarkMode ? Colors.white12 : viewLineColor, width: 3)),
          child: Text('${language.lblCategories} (${length})', style: boldTextStyle(size: 21, color: Colors.transparent)),
        ),
        Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(border: Border.all(color: appStore.isDarkMode ? Colors.white12 : viewLineColor, width: 3)),
          child: Text('${language.lblCategories} (${length})', style: boldTextStyle(size: 20, fontFamily: GoogleFonts.aclonica().fontFamily)),
        )
      ],
    );
  } else if (appStore.selectedMenuStyle == language.lblMenuStyle3) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${language.lblCategories} (${length})', style: boldTextStyle(size: 20, fontFamily: GoogleFonts.gloriaHallelujah().fontFamily)),
        Image.asset('images/ic_line.png', width: 100, color: appStore.isDarkMode ? Colors.white : Colors.black),
        16.height,
      ],
    );
  } else {
    return Text('${language.lblCategories} (${length})', style: boldTextStyle(size: 20));
  }
}

Widget getMenuCategoryListWidget(CategoryModel categoryData, bool isAdmin) {
  if (selectedRestaurant.menuStyle == 'Menu Style 3') {
    return MenuCategoryLisComponentStyleThree(categoryData: categoryData, isAdmin: isAdmin).paddingSymmetric(horizontal: 8);
  } else if (selectedRestaurant.menuStyle == 'Menu Style 2') {
    return MenuCategoryLisComponentStyleTwo(categoryData: categoryData, isAdmin: isAdmin);
  } else {
    return MenuListCategoryComponent(categoryData: categoryData, isAdmin: isAdmin);
  }
}

class GetMenuComponentWidget extends StatefulWidget {
  final MenuCategoryModel data;
  final bool isAdmin;

  GetMenuComponentWidget({required this.data, required this.isAdmin});

  @override
  _GetMenuComponentWidgetState createState() => _GetMenuComponentWidgetState();
}

class _GetMenuComponentWidgetState extends State<GetMenuComponentWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedRestaurant.menuStyle == 'Menu Style 2') {
      return Wrap(
        children: List.generate(widget.data.menu!.length, (i) {
          MenuModel menuData = widget.data.menu![i];
          if (menuData.status == false && !widget.isAdmin) {
            return Offstage();
          } else {
            return MenuComponentStyleTwo(menuModel: menuData).paddingSymmetric(horizontal: 8).onTap(() {
              if (widget.isAdmin) {
                push(AddMenuItemScreen(menuData: menuData), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds).then((value) {
                  setState(() {});
                });
              }
            });
          }
        }),
      );
    } else if (selectedRestaurant.menuStyle == 'Menu Style 3') {
      return Wrap(
        children: List.generate(widget.data.menu!.length, (i) {
          MenuModel menuData = widget.data.menu![i];
          if (menuData.status == false && !widget.isAdmin) {
            return Offstage();
          } else {
            return MenuComponentStyleThree(
              menuModel: menuData,
              isLast: i == (widget.data.menu.validate().length - 1) ? true : false,
            ).paddingSymmetric(horizontal: 8).onTap(() {
              if (widget.isAdmin) {
                push(AddMenuItemScreen(menuData: menuData), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds).then((value) {
                  setState(() {});
                });
              }
            });
          }
        }),
      );
    } else {
      return Responsive(
        mobile: Wrap(
          children: List.generate(widget.data.menu!.length, (i) {
            MenuModel menuData = widget.data.menu![i];
            if (menuData.status == false && !widget.isAdmin) {
              return Offstage();
            } else {
              return MenuComponentStyleOne(
                menuModel: menuData,
              ).onTap(() {
                if (widget.isAdmin) {
                  push(AddMenuItemScreen(menuData: menuData), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds).then((value) {
                    setState(() {});
                  });
                }
              });
            }
          }),
          spacing: 8,
          runSpacing: 8,
        ),
        web: Wrap(
          children: List.generate(widget.data.menu!.length, (i) {
            MenuModel menuData = widget.data.menu![i];
            if (menuData.status == false && !widget.isAdmin) {
              return Offstage();
            } else {
              return MenuComponentStyleOne(menuModel: menuData, isWeb: true).onTap(() {
                if (widget.isAdmin) {
                  push(AddMenuItemScreen(menuData: menuData), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds).then((value) {
                    setState(() {});
                  });
                }
              });
            }
          }),
          spacing: 8,
          runSpacing: 8,
          runAlignment: WrapAlignment.start,
        ),
        tablet: Wrap(
          children: List.generate(widget.data.menu!.length, (i) {
            MenuModel menuData = widget.data.menu![i];
            if (menuData.status == false && !widget.isAdmin) {
              return Offstage();
            } else {
              return MenuComponentStyleOne(menuModel: menuData, isTablet: true).onTap(() {
                if (widget.isAdmin) {
                  push(AddMenuItemScreen(menuData: menuData), pageRouteAnimation: PageRouteAnimation.Scale, duration: 450.milliseconds).then((value) {
                    setState(() {});
                  });
                }
              });
            }
          }),
          spacing: 8,
          runSpacing: 8,
        ),
      );
    }
  }
}

Widget getQrStyleWidget(bool isTesting, GlobalKey<State<StatefulWidget>> qrKey, String saveUrl) {
  if (appStore.selectedQrStyle == language.lblQrStyle2) {
    return QrComponentStyleTwo(isTesting: isTesting, qrKey: qrKey, saveUrl: saveUrl);
  } else if (appStore.selectedQrStyle == language.lblQrStyle3) {
    return QrComponentStyleThree(isTesting: isTesting, qrKey: qrKey, saveUrl: saveUrl);
  } else {
    return QrComponentStyleOne(isTesting: isTesting, qrKey: qrKey, saveUrl: saveUrl);
  }
}
