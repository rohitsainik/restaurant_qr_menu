import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  final String? id;

  AboutScreen({this.id});

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(language.lblAbout,
            color: context.scaffoldBackgroundColor),
        body: SnapHelperWidget<PackageInfoData>(
          future: getPackageInfo(),
          onSuccess: (data) => Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(language.lblRestaurantQRMenu,
                    style: boldTextStyle(size: 25)),
                16.height,
                isWeb
                    ? Container(
                        height: 4,
                        width: context.width() / 2,
                        constraints: BoxConstraints(maxWidth: 400),
                        color: primaryColor,
                      )
                    : Divider(
                        height: 16,
                        thickness: 4,
                        color: primaryColor,
                        endIndent: 250),
                16.height,
                Text('${language.lblVersion}:', style: boldTextStyle()),
                Text(data.versionName.validate(), style: primaryTextStyle()),
                8.height,
                Text(AppConstant.appDescription, style: secondaryTextStyle()),
                16.height,
                AppButton(
                  color: primaryColor,
                  onTap: () {
                    launch(Urls.codeCanyonURL);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.shopping_cart, color: white),
                      4.width,
                      Text(language.lblPurchase,
                          style: boldTextStyle(color: white)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
