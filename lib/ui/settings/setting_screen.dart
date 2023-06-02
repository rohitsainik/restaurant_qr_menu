import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/ui/auth/change_password_screen.dart';
import 'package:qr_menu/ui/auth/edit_profile_screen.dart';
import 'package:qr_menu/ui/menu/menu_style_screen.dart';
import 'package:qr_menu/ui/qr/qr_style_screen.dart';
import 'package:qr_menu/ui/settings/about_screen.dart';
import 'package:qr_menu/ui/settings/language_screen.dart';
import 'package:qr_menu/ui/settings/theme_screen.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  @override
  SettingScreenState createState() => SettingScreenState();
}

class SettingScreenState extends State<SettingScreen> {
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

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget trailingIcon({bool? isVersion}) {
    if (isVersion.validate()) {
      return Row(
        children: [
          SnapHelperWidget(
            future: getPackageInfo(),
            onSuccess: (PackageInfoData snap) {
              return Text(snap.versionName.validate(),
                  style: secondaryTextStyle());
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
    return Scaffold(
      appBar: appBarWidget('',
          color: context.scaffoldBackgroundColor, elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.lblSettings, style: boldTextStyle(size: 34))
                .paddingSymmetric(horizontal: 16),
            16.height,
            SettingItemWidget(
              title: '${language.lblEditProfile}',
              leading: Icon(LineIcons.edit, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                push(EditProfileScreen());
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(Icons.password_sharp, size: 20),
              title: '${language.lblChangePassword}',
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                if (getBoolAsync(SharePreferencesKey.IS_EMAIL_LOGIN)) {
                  push(ChangePasswordScreen());
                } else {
                  toast(language
                      .lblUserLoginWithSocialAccountCannotChangeThePassword);
                }
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              leading: Icon(Icons.translate, color: context.iconColor),
              title: "${language.lblLanguage}",
              titleTextStyle: boldTextStyle(size: 16),
              trailing: Row(
                children: [
                  TextIcon(
                    text: selectedLanguageDataModel!.name.validate(),
                    prefix: Image.asset(
                        selectedLanguageDataModel!.flag.validate(),
                        width: 24,
                        height: 24),
                  ),
                  8.width,
                  Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 14),
                ],
              ),
              onTap: () {
                push(LanguageScreen(),
                    pageRouteAnimation: PageRouteAnimation.Slide);
              },
            ),
            //tWg6tNJtGFMYzWy7p5GFFc7zxLy1
            Observer(
              builder: (_) => SettingItemWidget(
                title: language.lblDarkMode,
                leading: Icon(
                    !appStore.isDarkMode
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined,
                    size: 20),
                titleTextStyle: boldTextStyle(size: 16),
                onTap: () {
                  push(ThemeScreen(),
                      pageRouteAnimation: PageRouteAnimation.Slide);
                },
                trailing: trailingIcon(),
              ),
            ),
            SettingItemWidget(
              title: language.lblSetMenuStyle,
              leading: Icon(Icons.style_outlined, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                MenuStyleScreen().launch(context);
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              title: language.lblSetQrStyle,
              leading: Icon(Icons.qr_code_rounded, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                QrStyleScreen().launch(context);
              },
              trailing: trailingIcon(),
            ),
            SettingItemWidget(
              title: language.lblPrivacyPolicy,
              leading: Icon(Icons.privacy_tip_outlined, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              trailing: trailingIcon(),
              onTap: () {
                launch(Urls.privacyPolicyURL);
              },
            ),
            isWeb
                ? Offstage()
                : SnapHelperWidget<PackageInfoData>(
                    onSuccess: (d) => SettingItemWidget(
                      leading: Icon(Icons.rate_review_outlined, size: 20),
                      titleTextStyle: boldTextStyle(size: 16),
                      title: language.lblRateUs,
                      onTap: () {
                        launch('$playStoreBaseURL${d.packageName}');
                      },
                      trailing: trailingIcon(),
                    ),
                    future: getPackageInfo(),
                  ),
            SettingItemWidget(
              leading: Icon(LineIcons.file, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              title: language.lblHelpSupport,
              onTap: () {
                launchUrlCommon(Urls.termsAndConditionURL);
              },
              trailing: trailingIcon(),
            ),
            isWeb
                ? Offstage()
                : SettingItemWidget(
                    leading: Icon(Icons.share_outlined, size: 20),
                    titleTextStyle: boldTextStyle(size: 16),
                    title: language.lblShare,
                    onTap: () {
                      Share.share(
                        'Share ${AppConstant.appName} app\n\n${AppConstant.appDescription}\n\n$playStoreBaseURL${Urls.packageName}',
                      );
                    },
                  ),
            SettingItemWidget(
              title: language.lblAbout,
              leading: Icon(Icons.perm_device_info, size: 20),
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                AboutScreen().launch(context);
              },
              trailing: trailingIcon(isVersion: true),
            ),
            SettingItemWidget(
              leading: Icon(Icons.login_outlined, size: 20),
              title: language.lblLogout,
              titleTextStyle: boldTextStyle(size: 16),
              onTap: () {
                showConfirmDialogCustom(
                  context,
                  primaryColor:
                      appStore.isDarkMode ? Colors.white : primaryColor,
                  dialogType: DialogType.CONFIRMATION,
                  title: '${language.lblAreYouSureYouWantToLogout}?',
                  onAccept: (context) {
                    hideKeyboard(context);
                    toast(language.lblVisitAgain);
                    authService.logout(context);
                  },
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
