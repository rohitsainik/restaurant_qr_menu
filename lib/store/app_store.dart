import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/language/AppLocalizations.dart';
import 'package:qr_menu/language/Languages.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/menu_category_model.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/constants.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  bool isAdmin = false;

  @observable
  String selectedLanguage = "";

  @observable
  String selectedMenuStyle = "";

  @observable
  String selectedQrStyle = "";

  @observable
  bool isNotificationOn = true;

  @observable
  bool isDarkMode = false;

  @observable
  bool isLoading = false;

  @observable
  bool isTester = false;

  @observable
  String userProfileImage = '';

  @observable
  String userFullName = '';

  @observable
  String userEmail = '';

  @observable
  String userId = '';

  @observable
  List<MenuCategoryModel> menuListByCategory = [];

  @observable
  bool isAll = true;

  @action
  void setIsAll(bool setIsAll) {
    isAll = setIsAll;
  }

  @action
  void setMenuByCategoryList(List<MenuCategoryModel> list) {
    menuListByCategory = list;
  }

  @action
  void setUserProfile(String image) {
    userProfileImage = image;
  }

  @action
  Future<void> setIsTester(bool val, {bool isInitializing = false}) async {
    isTester = val;
    if (!isInitializing)
      await setValue(SharePreferencesKey.IS_TESTER, isTester);
  }

  @action
  void setAdminRole(bool val) {
    isAdmin = val;
  }

  @action
  void setUserId(String val) {
    userId = val;
  }

  @action
  void setUserEmail(String email) {
    userEmail = email;
  }

  @action
  void setFullName(String name) {
    userFullName = name;
  }

  @action
  Future<void> setLoggedIn(bool val) async {
    isLoggedIn = val;
    await setValue(SharePreferencesKey.IS_LOGGED_IN, val);
  }

  @action
  void setLoading(bool val) {
    isLoading = val;
  }

  @action
  void setNotification(bool val) {
    isNotificationOn = val;

    setValue(SharePreferencesKey.IS_NOTIFICATION_ON, val);
  }

  @action
  Future<void> setDarkMode(bool aIsDarkMode) async {
    isDarkMode = aIsDarkMode;

    if (isDarkMode) {
      textPrimaryColorGlobal = Colors.white;
      textSecondaryColorGlobal = viewLineColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = Colors.white;
      shadowColorGlobal = Colors.white12;

      setStatusBarColor(scaffoldSecondaryDark);
    } else {
      textPrimaryColorGlobal = textPrimaryColor;
      textSecondaryColorGlobal = textSecondaryColor;

      defaultLoaderBgColorGlobal = Colors.white;
      appButtonBackgroundColorGlobal = primaryColor;
      shadowColorGlobal = Colors.black12;

      setStatusBarColor(Colors.white);
    }
  }

  @action
  Future<void> setLanguage(String aCode, {BuildContext? context}) async {
    selectedLanguageDataModel =
        getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage);
    selectedLanguage =
        getSelectedLanguageModel(defaultLanguage: AppConstant.defaultLanguage)!
            .languageCode!;

    if (context != null) language = BaseLanguage.of(context)!;
    language = await AppLocalizations().load(Locale(selectedLanguage));
  }

  @action
  void setMenuStyle(String style) {
    selectedMenuStyle = style;
  }

  @action
  void setQrStyle(String style) {
    selectedQrStyle = style;
  }
}
