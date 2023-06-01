// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$isLoggedInAtom =
      Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isAdminAtom = Atom(name: '_AppStore.isAdmin', context: context);

  @override
  bool get isAdmin {
    _$isAdminAtom.reportRead();
    return super.isAdmin;
  }

  @override
  set isAdmin(bool value) {
    _$isAdminAtom.reportWrite(value, super.isAdmin, () {
      super.isAdmin = value;
    });
  }

  late final _$selectedLanguageAtom =
      Atom(name: '_AppStore.selectedLanguage', context: context);

  @override
  String get selectedLanguage {
    _$selectedLanguageAtom.reportRead();
    return super.selectedLanguage;
  }

  @override
  set selectedLanguage(String value) {
    _$selectedLanguageAtom.reportWrite(value, super.selectedLanguage, () {
      super.selectedLanguage = value;
    });
  }

  late final _$selectedMenuStyleAtom =
      Atom(name: '_AppStore.selectedMenuStyle', context: context);

  @override
  String get selectedMenuStyle {
    _$selectedMenuStyleAtom.reportRead();
    return super.selectedMenuStyle;
  }

  @override
  set selectedMenuStyle(String value) {
    _$selectedMenuStyleAtom.reportWrite(value, super.selectedMenuStyle, () {
      super.selectedMenuStyle = value;
    });
  }

  late final _$selectedQrStyleAtom =
      Atom(name: '_AppStore.selectedQrStyle', context: context);

  @override
  String get selectedQrStyle {
    _$selectedQrStyleAtom.reportRead();
    return super.selectedQrStyle;
  }

  @override
  set selectedQrStyle(String value) {
    _$selectedQrStyleAtom.reportWrite(value, super.selectedQrStyle, () {
      super.selectedQrStyle = value;
    });
  }

  late final _$isNotificationOnAtom =
      Atom(name: '_AppStore.isNotificationOn', context: context);

  @override
  bool get isNotificationOn {
    _$isNotificationOnAtom.reportRead();
    return super.isNotificationOn;
  }

  @override
  set isNotificationOn(bool value) {
    _$isNotificationOnAtom.reportWrite(value, super.isNotificationOn, () {
      super.isNotificationOn = value;
    });
  }

  late final _$isDarkModeAtom =
      Atom(name: '_AppStore.isDarkMode', context: context);

  @override
  bool get isDarkMode {
    _$isDarkModeAtom.reportRead();
    return super.isDarkMode;
  }

  @override
  set isDarkMode(bool value) {
    _$isDarkModeAtom.reportWrite(value, super.isDarkMode, () {
      super.isDarkMode = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isTesterAtom =
      Atom(name: '_AppStore.isTester', context: context);

  @override
  bool get isTester {
    _$isTesterAtom.reportRead();
    return super.isTester;
  }

  @override
  set isTester(bool value) {
    _$isTesterAtom.reportWrite(value, super.isTester, () {
      super.isTester = value;
    });
  }

  late final _$userProfileImageAtom =
      Atom(name: '_AppStore.userProfileImage', context: context);

  @override
  String get userProfileImage {
    _$userProfileImageAtom.reportRead();
    return super.userProfileImage;
  }

  @override
  set userProfileImage(String value) {
    _$userProfileImageAtom.reportWrite(value, super.userProfileImage, () {
      super.userProfileImage = value;
    });
  }

  late final _$userFullNameAtom =
      Atom(name: '_AppStore.userFullName', context: context);

  @override
  String get userFullName {
    _$userFullNameAtom.reportRead();
    return super.userFullName;
  }

  @override
  set userFullName(String value) {
    _$userFullNameAtom.reportWrite(value, super.userFullName, () {
      super.userFullName = value;
    });
  }

  late final _$userEmailAtom =
      Atom(name: '_AppStore.userEmail', context: context);

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  late final _$userIdAtom = Atom(name: '_AppStore.userId', context: context);

  @override
  String get userId {
    _$userIdAtom.reportRead();
    return super.userId;
  }

  @override
  set userId(String value) {
    _$userIdAtom.reportWrite(value, super.userId, () {
      super.userId = value;
    });
  }

  late final _$menuListByCategoryAtom =
      Atom(name: '_AppStore.menuListByCategory', context: context);

  @override
  List<MenuCategoryModel> get menuListByCategory {
    _$menuListByCategoryAtom.reportRead();
    return super.menuListByCategory;
  }

  @override
  set menuListByCategory(List<MenuCategoryModel> value) {
    _$menuListByCategoryAtom.reportWrite(value, super.menuListByCategory, () {
      super.menuListByCategory = value;
    });
  }

  late final _$isAllAtom = Atom(name: '_AppStore.isAll', context: context);

  @override
  bool get isAll {
    _$isAllAtom.reportRead();
    return super.isAll;
  }

  @override
  set isAll(bool value) {
    _$isAllAtom.reportWrite(value, super.isAll, () {
      super.isAll = value;
    });
  }

  late final _$setIsTesterAsyncAction =
      AsyncAction('_AppStore.setIsTester', context: context);

  @override
  Future<void> setIsTester(bool val, {bool isInitializing = false}) {
    return _$setIsTesterAsyncAction
        .run(() => super.setIsTester(val, isInitializing: isInitializing));
  }

  late final _$setLoggedInAsyncAction =
      AsyncAction('_AppStore.setLoggedIn', context: context);

  @override
  Future<void> setLoggedIn(bool val) {
    return _$setLoggedInAsyncAction.run(() => super.setLoggedIn(val));
  }

  late final _$setDarkModeAsyncAction =
      AsyncAction('_AppStore.setDarkMode', context: context);

  @override
  Future<void> setDarkMode(bool aIsDarkMode) {
    return _$setDarkModeAsyncAction.run(() => super.setDarkMode(aIsDarkMode));
  }

  late final _$setLanguageAsyncAction =
      AsyncAction('_AppStore.setLanguage', context: context);

  @override
  Future<void> setLanguage(String aCode, {BuildContext? context}) {
    return _$setLanguageAsyncAction
        .run(() => super.setLanguage(aCode, context: context));
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setIsAll(bool setIsAll) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setIsAll');
    try {
      return super.setIsAll(setIsAll);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMenuByCategoryList(List<MenuCategoryModel> list) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setMenuByCategoryList');
    try {
      return super.setMenuByCategoryList(list);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserProfile(String image) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setUserProfile');
    try {
      return super.setUserProfile(image);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setAdminRole(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setAdminRole');
    try {
      return super.setAdminRole(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserId(String val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setUserId');
    try {
      return super.setUserId(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserEmail(String email) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setUserEmail');
    try {
      return super.setUserEmail(email);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFullName(String name) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setFullName');
    try {
      return super.setFullName(name);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNotification(bool val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setNotification');
    try {
      return super.setNotification(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMenuStyle(String style) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setMenuStyle');
    try {
      return super.setMenuStyle(style);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQrStyle(String style) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setQrStyle');
    try {
      return super.setQrStyle(style);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
isAdmin: ${isAdmin},
selectedLanguage: ${selectedLanguage},
selectedMenuStyle: ${selectedMenuStyle},
selectedQrStyle: ${selectedQrStyle},
isNotificationOn: ${isNotificationOn},
isDarkMode: ${isDarkMode},
isLoading: ${isLoading},
isTester: ${isTester},
userProfileImage: ${userProfileImage},
userFullName: ${userFullName},
userEmail: ${userEmail},
userId: ${userId},
menuListByCategory: ${menuListByCategory},
isAll: ${isAll}
    ''';
  }
}
