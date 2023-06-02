import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/veg_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/utils/cached_network_image.dart';

class MenuComponentStyleTwo extends StatelessWidget {
  final MenuModel? menuModel;

  MenuComponentStyleTwo({this.menuModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        4.height,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                menuModel!.isVeg.validate()
                    ? VegComponent(
                        size: 16, isAvailableToday: menuModel!.isAvailableToday)
                    : NonVegComponent(
                        size: 16,
                        isAvailableToday: menuModel!.isAvailableToday),
                8.width,
                Stack(
                  children: [
                    Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                          color: context.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: context.dividerColor)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: menuModel!.image.isEmptyOrNull
                            ? Text(
                                '${menuModel!.name!.validate()[0].toUpperCase()}',
                                style: boldTextStyle(size: 14),
                              ).center()
                            : cachedImage(menuModel!.image, fit: BoxFit.cover),
                      ),
                    ),
                    if (menuModel!.isAvailableToday == false)
                      Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: context.dividerColor),
                        ),
                      ),
                  ],
                ),
                4.width,
                Text(
                  '${menuModel!.name!.trim()}',
                  style: boldTextStyle(
                    size: 18,
                    color: menuModel!.isAvailableToday == false
                        ? Colors.grey
                        : context.iconColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ).flexible(),
                4.width,
                if (menuModel!.status == false)
                  Icon(
                    Icons.circle,
                    color: menuModel!.isAvailableToday == false
                        ? Colors.grey
                        : Colors.red,
                    size: 10,
                  ),
                6.width,
                menuModel!.isJain.validate() &&
                        menuModel!.isAvailableToday != false
                    ? Text('J',
                        style: boldTextStyle(size: 16, color: Colors.red))
                    : Offstage(),
                menuModel!.isSpicy.validate() &&
                        menuModel!.isAvailableToday != false
                    ? Image.asset('images/chili.png', height: 16, width: 16)
                    : Offstage(),
              ],
            ).expand(),
            Text('${selectedRestaurant.currency}${menuModel!.price}',
                style: boldTextStyle(
                  size: 18,
                  color: menuModel!.isAvailableToday == false
                      ? Colors.grey
                      : context.iconColor,
                )),
          ],
        ),
        if (menuModel!.isAvailableToday == false)
          Text(
            'This item is not available for today',
            style: secondaryTextStyle(color: Colors.red, size: 10),
          ),
        4.height,
      ],
    );
  }
}
