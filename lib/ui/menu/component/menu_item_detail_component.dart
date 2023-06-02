import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/colors.dart';

// ignore: must_be_immutable
class MenuItemDetailComponent extends StatefulWidget {
  final String title;
  final String subtitle;
  bool isSelected;
  final bool? isTappedEnabled;
  final Function(bool val) onChanged;

  MenuItemDetailComponent(
      {required this.title,
      required this.subtitle,
      required this.isSelected,
      required this.onChanged,
      this.isTappedEnabled});

  @override
  _MenuItemDetailComponentState createState() =>
      _MenuItemDetailComponentState();
}

class _MenuItemDetailComponentState extends State<MenuItemDetailComponent> {
  bool isSelected = false;

  @override
  void initState() {
    isSelected = widget.isSelected;
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() / 2 - 24,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: radius(defaultRadius),
        color: !isSelected ? context.cardColor : primaryColor.withAlpha(60),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                !isSelected
                    ? '${language.lblEnable}'
                    : '${language.lblDisable}',
                style: primaryTextStyle(),
              ).expand(),
              Tooltip(
                waitDuration: 200.milliseconds,
                margin: EdgeInsets.symmetric(horizontal: 36),
                message: '${widget.subtitle}',
                triggerMode: TooltipTriggerMode.tap,
                child: Icon(Icons.info_outline,
                    color: context.iconColor, size: 16),
              )
            ],
          ),
          12.height,
          Text(widget.title, style: boldTextStyle()),
          8.height,
          Text(
            '${widget.subtitle}',
            style: secondaryTextStyle(size: 10),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).onTap(() {
      if (widget.isTappedEnabled.validate(value: false)) {
        widget.onChanged(false);
      } else {
        isSelected = !isSelected;
        widget.onChanged(isSelected);
      }
      setState(() {});
    }, borderRadius: radius(defaultRadius));
  }
}
