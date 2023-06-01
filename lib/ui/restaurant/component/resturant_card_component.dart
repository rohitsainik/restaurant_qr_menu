import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/veg_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/services/category_service.dart';
import 'package:qr_menu/services/menu_service.dart';
import 'package:qr_menu/ui/restaurant/res_detail_screen.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';

class RestaurantCardComponent extends StatefulWidget {
  final RestaurantModel data;

  RestaurantCardComponent({required this.data});

  @override
  State<RestaurantCardComponent> createState() => _RestaurantCardComponentState();
}

class _RestaurantCardComponentState extends State<RestaurantCardComponent> {
  Widget checkRestaurantType({required bool isVeg, required bool isNonVeg}) {
    double size = 20;
    if (isNonVeg && isVeg) {
      return Row(
        children: [VegComponent(size: size), 8.width, NonVegComponent(size: size)],
      );
    } else if (isVeg) {
      return VegComponent(size: size);
    } else if (isNonVeg) {
      return NonVegComponent(size: size);
    } else {
      return Offstage();
    }
  }

  @override
  void initState() {
    appStore.setMenuStyle(widget.data.menuStyle.validate());
    setValue(SharePreferencesKey.MENU_STYLE, widget.data.menuStyle.validate());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          widget.data.image!.isNotEmpty
              ? cachedImage(
                  widget.data.image.validate(value: "https://image.freepik.com/free-photo/indian-condiments-with-copy-space-view_23-2148723492.jpg"),
                  height: 250,
                  width: context.width(),
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(defaultRadius)
              : cachedImage(
                  '',
                  height: 250,
                  width: context.width(),
                  fit: BoxFit.cover,
                ).cornerRadiusWithClipRRect(defaultRadius),
          Container(
            decoration: blackBoxDecoration(),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    cachedImage(
                      widget.data.logoImage.validate(),
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ).cornerRadiusWithClipRRect(80),
                    16.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.data.name}', style: boldTextStyle(size: 20, color: Colors.white)),
                        4.height,
                        if (widget.data.description.isEmptyOrNull)
                          Text(
                            '${widget.data.description}',
                            style: secondaryTextStyle(color: Colors.white70, size: 14),
                          ),
                      ],
                    ).expand(),
                  ],
                ),
                16.height,
                Row(
                  children: [
                    StreamBuilder(
                      stream: CategoryService.getTotalCategories(restaurantId: widget.data.uid),
                      builder: (_, snap) {
                        if (snap.hasData) {
                          return Column(
                            children: [
                              Text('${snap.data.toString()}', style: boldTextStyle(color: Colors.white, size: 20)),
                              Text(language.lblCategories, style: primaryTextStyle(size: 16, color: Colors.white)),
                            ],
                          );
                        }
                        return snapWidgetHelper(snap, loadingWidget: Offstage());
                      },
                    ).expand(),
                    StreamBuilder(
                      stream: MenuService.getTotalMenus(restaurantId: widget.data.uid),
                      builder: (_, snap) {
                        if (snap.hasData) {
                          return Column(
                            children: [
                              Text('${snap.data.toString()}', style: boldTextStyle(color: Colors.white, size: 20)),
                              Text(language.lblFoodItems, style: primaryTextStyle(size: 16, color: Colors.white)),
                            ],
                          );
                        }
                        return snapWidgetHelper(snap, loadingWidget: Offstage());
                      },
                    ).expand(),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: radius(8), color: context.cardColor),
              child: checkRestaurantType(isVeg: widget.data.isVeg.validate(), isNonVeg: widget.data.isNonVeg.validate()),
            ),
          ),
        ],
      ),
    ).onTap(() {
      log('.............${widget.data.uid}');
      menuService = MenuService(restaurantId: widget.data.uid);
      menuStore.setSelectedCategoryData(null);
      push(ResDetailScreen(data: widget.data), pageRouteAnimation: PageRouteAnimation.Slide);
    }, borderRadius: radius(defaultRadius));
  }
}
