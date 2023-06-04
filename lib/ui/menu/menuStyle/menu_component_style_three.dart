import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/utils/cached_network_image.dart';

class MenuComponentStyleThree extends StatelessWidget {
  final MenuModel? menuModel;
  final bool isLast;

  MenuComponentStyleThree({this.menuModel, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        border: TableBorder(
          top: BorderSide(color: context.dividerColor, width: 2),
          bottom: isLast
              ? BorderSide(color: context.dividerColor, width: 2)
              : BorderSide(
                  color: context.dividerColor,
                  width: 0.5,
                ),
          verticalInside: BorderSide(color: context.dividerColor, width: 2),
        ),
        columnWidths: {
          0: FlexColumnWidth(),
          1: FixedColumnWidth(100.0), //fixed to 100 width
        },
        children: [
          TableRow(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              color: context.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: context.dividerColor),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: menuModel?.image?.isEmpty == true
                                   ? Text(
                                      '${menuModel?.name?.validate()[0].toUpperCase()}',
                                      style: boldTextStyle(size: 14),
                                    ).center()
                                  : cachedImage(menuModel?.image,
                                      fit: BoxFit.cover),
                            ),
                          ),
                          if (menuModel?.isAvailableToday == false)
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
                        '${menuModel?.name?.trim()}',
                        style: boldTextStyle(
                          size: 16,
                          color: menuModel?.isAvailableToday == false
                              ? Colors.grey
                              : context.iconColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      4.width,
                      4.width,
                      if (menuModel?.status == false)
                        Icon(
                          Icons.circle,
                          color: menuModel?.isAvailableToday == false
                              ? Colors.grey
                              : Colors.red,
                          size: 12,
                        ),
                      6.width,
                      menuModel?.isJain.validate() == true &&
                              menuModel?.isAvailableToday != false
                          ? Text(
                              'J',
                              style: boldTextStyle(size: 16, color: Colors.red),
                            )
                          : Offstage(),
                      menuModel?.isSpicy.validate() == true &&
                              menuModel?.isAvailableToday != false
                          ? Image.asset(
                              'images/chili.png',
                              height: 16,
                              width: 16,
                            )
                          : Offstage(),
                    ],
                  ),
                  4.height,
                  if (menuModel?.ingredient.validate().isNotEmpty == true)
                    Wrap(
                      children: List.generate(
                          menuModel?.ingredient.validate().length ?? 0, (index) {
                        return Text(
                          '${menuModel?.ingredient?[index].capitalizeFirstLetter()}',
                          style: primaryTextStyle(
                            size: 12,
                            color: menuModel?.isAvailableToday == false
                                ? Colors.grey
                                : context.iconColor,
                          ),
                        );
                      }),
                    ),
                  if (menuModel?.isAvailableToday == false)
                    Text(
                      'This item is not available for today',
                      style: secondaryTextStyle(color: Colors.red, size: 10),
                    ),
                ],
              ).paddingAll(8),
              Text(
                '${selectedRestaurant.currency}${menuModel?.price}',
                style: boldTextStyle(
                  size: 20,
                  color: menuModel?.isAvailableToday == false
                      ? Colors.grey
                      : context.iconColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ).paddingAll(8),
            ],
          ),
        ],
      ),
    );
  }
}
