import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/ui/settings/language_screen.dart';
import 'package:qr_menu/ui/settings/theme_screen.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UserSettingScreen extends StatefulWidget {
  const UserSettingScreen({Key? key}) : super(key: key);

  @override
  _UserSettingScreenState createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget trailingIcon({bool? isVersion}) {
    if (isVersion.validate()) {
      return Row(
        children: [
          SnapHelperWidget(
            future: getPackageInfo(),
            onSuccess: (PackageInfoData snap) {
              return Text(snap.versionName.validate(), style: secondaryTextStyle());
            },
          ),
          8.width,
          Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
        ],
      );
    } else {
      return Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget('', color: context.scaffoldBackgroundColor, elevation: 0),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.lblSettings, style: boldTextStyle(size: 34)).paddingSymmetric(horizontal: 16),
            16.height,
            Observer(
              builder: (_) => SettingItemWidget(
                title: language.lblDarkMode,
                leading: Icon(!appStore.isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined, size: 20),
                titleTextStyle: primaryTextStyle(size: 16),
                onTap: () {
                  push(ThemeScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
                },
                trailing: trailingIcon(),
              ),
            ),
            SettingItemWidget(
              leading: Icon(Icons.translate, color: context.iconColor),
              title: "${language.lblLanguage}",
              titleTextStyle: primaryTextStyle(size: 16),
              trailing: Row(
                children: [
                  TextIcon(
                    text: selectedLanguageDataModel!.name.validate(),
                    prefix: Image.asset(selectedLanguageDataModel!.flag.validate(), width: 24, height: 24),
                  ),
                  8.width,
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                ],
              ),
              onTap: () {
                push(LanguageScreen(), pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            SettingItemWidget(
              title: language.lblPrivacyPolicy,
              leading: Icon(Icons.privacy_tip_outlined, size: 20),
              titleTextStyle: primaryTextStyle(size: 16),
              trailing: trailingIcon(),
              onTap: () {
                launch(Urls.appShareURL);
              },
            ),
            SettingItemWidget(
              leading: Icon(Icons.rate_review_outlined, size: 20),
              titleTextStyle: primaryTextStyle(size: 16),
              title: language.lblRateUs,
              onTap: () {
                launch(Urls.appShareURL);
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(Icons.insert_drive_file_outlined, size: 20),
              titleTextStyle: primaryTextStyle(size: 16),
              title: language.lblTerms,
              onTap: () {
                launchUrlCommon(Urls.termsAndConditionURL);
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(Icons.share_outlined, size: 20),
              titleTextStyle: primaryTextStyle(size: 16),
              title: language.lblShare,
              onTap: () {
                Share.share(
                  'Share ${AppConstant.appName} app\n\n${AppConstant.appDescription}\n\n$playStoreBaseURL${Urls.packageName}',
                );
              },
            ),
            16.height,
          ],
        ),
      ),
    );
  }
}
