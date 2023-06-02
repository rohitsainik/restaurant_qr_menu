import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/qr_style_model.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/constants.dart';

class QrStyleScreen extends StatefulWidget {
  const QrStyleScreen({Key? key}) : super(key: key);

  @override
  _QrStyleScreenState createState() => _QrStyleScreenState();
}

class _QrStyleScreenState extends State<QrStyleScreen> {
  int? selectedIndex;

  List<QrStyleModel> data = QrStyleModel.getQrStyleList();

  @override
  void initState() {
    selectedIndex = data
        .indexWhere((element) => element.styleName == appStore.selectedQrStyle);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        language.lblSetQrStyle,
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
              selectedIndex = index;
              appStore.setQrStyle(data[index].styleName.validate());
              setValue(SharePreferencesKey.QR_STYLE, data[index].styleName);
              setState(() {});
            }, borderRadius: radius(defaultRadius));
          }),
        ),
      ),
    );
  }
}
