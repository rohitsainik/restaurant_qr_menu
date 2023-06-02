import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/veg_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/menu_model.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/colors.dart';

// ignore: must_be_immutable
class MenuComponentStyleOne extends StatefulWidget {
  final MenuModel? menuModel;
  bool? isTablet;
  bool? isWeb;

  MenuComponentStyleOne({this.menuModel, this.isTablet, this.isWeb});

  @override
  _MenuComponentStyleOneState createState() => _MenuComponentStyleOneState();
}

class _MenuComponentStyleOneState extends State<MenuComponentStyleOne> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    if (Timestamp.now().toDate().day -
            selectedRestaurant.newItemForDays.validate() <=
        0) {
      if (widget.menuModel!.isNew.validate()) {
        widget.menuModel!.isNew = true;
      } else {
        widget.menuModel!.isNew = false;
      }
    } else {
      if (!widget.menuModel!.isNew.validate()) {
        widget.menuModel!.isNew = false;
      } else {
        widget.menuModel!.isNew = true;
      }
    }
  }

  List<String> getMenuType() {
    List<bool> menuTypeBool = [
      widget.menuModel!.isSpicy.validate(),
      widget.menuModel!.isJain.validate(),
      widget.menuModel!.isSpecial.validate(),
      widget.menuModel!.isPopular.validate(),
      widget.menuModel!.isSweet.validate(),
    ];
    List<String> menuTypeText = [
      language.lblSpicy,
      language.lblJain,
      language.lblSpecial,
      language.lblPopular,
      language.lblSweet,
    ];
    List<String> toPrint = [];

    menuTypeText.forEach((element) {
      int index = menuTypeText.indexOf(element);
      menuTypeBool[index] ? toPrint.add(element) : null;
    });
    return toPrint;
  }

  Widget checkIndicatorExist() {
    if (widget.menuModel!.isSpicy == false &&
        widget.menuModel!.isJain == false &&
        widget.menuModel!.isPopular == false &&
        widget.menuModel!.isSpecial == false) {
      return Offstage();
    }
    return Divider();
  }

  double getWidth() {
    if (widget.isTablet.validate()) {
      return context.width() / 2;
    } else if (widget.isWeb.validate()) {
      return context.width() / 3 - 32;
    }
    return context.width() / 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: radius(defaultRadius),
        color: context.cardColor,
        border: Border.all(color: context.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.menuModel!.isVeg.validate()
                  ? VegComponent(
                      size: 18,
                      isAvailableToday: widget.menuModel!.isAvailableToday)
                  : NonVegComponent(
                      size: 18,
                      isAvailableToday: widget.menuModel!.isAvailableToday),
              8.width,
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
                      child: widget.menuModel!.image.isEmptyOrNull
                          ? Text(
                              '${widget.menuModel!.name!.validate()[0].toUpperCase()}',
                              style: boldTextStyle(size: 14),
                            ).center()
                          : cachedImage(widget.menuModel!.image,
                              fit: BoxFit.cover),
                    ),
                  ),
                  if (widget.menuModel!.isAvailableToday == false)
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
              Row(
                children: [
                  Text(
                    '${widget.menuModel!.name!.trim()}',
                    style: boldTextStyle(
                      color: widget.menuModel!.isAvailableToday == false
                          ? Colors.grey
                          : context.iconColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ).flexible(),
                  4.width,
                  if (widget.menuModel!.status == false)
                    Icon(
                      Icons.circle,
                      color: widget.menuModel!.isAvailableToday == false
                          ? Colors.grey
                          : Colors.red,
                      size: 12,
                    )
                ],
              ).expand(),
              widget.menuModel!.isNew.validate() &&
                      widget.menuModel!.isAvailableToday != false
                  ? Container(
                      child: Text(language.lblNew,
                          style: primaryTextStyle(size: 14, color: Colors.red)),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: radius(defaultRadius),
                        color: Colors.red.withOpacity(0.1),
                      ),
                    )
                  : Container(
                      child: Text('',
                          style: primaryTextStyle(size: 14, color: Colors.red)),
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: radius(defaultRadius),
                          color: Colors.transparent),
                    ),
            ],
          ),
          12.height,
          widget.menuModel!.ingredient!.isNotEmpty
              ? Wrap(
                  spacing: 4,
                  children: List.generate(
                    widget.menuModel!.ingredient!.length,
                    (index) {
                      if (index == widget.menuModel!.ingredient!.length - 1) {
                        return ReadMoreText(
                          '${widget.menuModel!.ingredient?[index].capitalizeFirstLetter()}',
                          style: primaryTextStyle(
                            size: 14,
                            color: widget.menuModel!.isAvailableToday == false
                                ? Colors.grey
                                : context.iconColor,
                          ),
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: '${language.lblShowMore}',
                          trimExpandedText: '${language.lblShowLess}',
                        );
                      }
                      return ReadMoreText(
                        '${widget.menuModel!.ingredient?[index].capitalizeFirstLetter()},',
                        style: primaryTextStyle(
                          size: 14,
                          color: widget.menuModel!.isAvailableToday == false
                              ? Colors.grey
                              : context.iconColor,
                        ),
                        trimLines: 2,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: '${language.lblShowMore}',
                        trimExpandedText: '${language.lblShowLess}',
                      );
                    },
                  ),
                )
              : SizedBox(height: 20),
          Divider(height: 16),
          Row(
            children: [
              Text(
                '${selectedRestaurant.currency}${widget.menuModel!.price}',
                style: boldTextStyle(
                  size: 20,
                  color: widget.menuModel!.isAvailableToday == false
                      ? Colors.grey
                      : context.iconColor,
                ),
              ).expand(),
              Wrap(
                children: List.generate(
                  getMenuType().length,
                  (index) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getMenuType()[index],
                          style: secondaryTextStyle(
                            size: 12,
                            color: widget.menuModel!.isAvailableToday == false
                                ? Colors.grey
                                : context.iconColor,
                          ),
                        ),
                        index == (getMenuType().length - 1)
                            ? Text(
                                '',
                                style: secondaryTextStyle(
                                  size: 12,
                                  color: widget.menuModel!.isAvailableToday ==
                                          false
                                      ? Colors.grey
                                      : context.iconColor,
                                ),
                              )
                            : Text(
                                ', ',
                                style: secondaryTextStyle(
                                  size: 12,
                                  color: widget.menuModel!.isAvailableToday ==
                                          false
                                      ? Colors.grey
                                      : context.iconColor,
                                ),
                              )
                      ],
                    );
                  },
                ),
              )
            ],
          ),
          4.height,
          if (widget.menuModel!.isAvailableToday == false)
            Text(
              'This item is not available for today',
              style: secondaryTextStyle(color: Colors.red),
            ).center(),
        ],
      ),
    );
  }
}
