import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/app_theme.dart';
import 'package:qr_menu/language/AppLocalizations.dart';
import 'package:qr_menu/language/Languages.dart';
import 'package:qr_menu/models/material_you_model.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/services/auth_service.dart';
import 'package:qr_menu/services/category_service.dart';
import 'package:qr_menu/services/menu_service.dart';
import 'package:qr_menu/services/restaurant_owner_service.dart';
import 'package:qr_menu/services/user_service.dart';
import 'package:qr_menu/store/app_store.dart';
import 'package:qr_menu/store/menu_store.dart';
import 'package:qr_menu/ui/splash_screen.dart';
import 'package:qr_menu/ui/userSide/user_splash_screen.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';
import 'package:qr_menu/utils/constants.dart';
import 'package:url_strategy/url_strategy.dart';

//region Global Variables
FirebaseFirestore fireStore = FirebaseFirestore.instance;

AppStore appStore = AppStore();
MenuStore menuStore = MenuStore();

FirebaseStorage storage = FirebaseStorage.instance;
UserService userService = UserService();
RestaurantOwnerService restaurantOwnerService = RestaurantOwnerService();
MenuService menuService = MenuService();
AuthService authService = AuthService();
RestaurantModel selectedRestaurant = RestaurantModel();
CategoryService categoryService = CategoryService();

late BaseLanguage language;
//endregion

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();
  await Firebase.initializeApp(
      name: "restroqr",
      options: FirebaseOptions(
          apiKey: "AIzaSyCBYiHUOeQ5hAtUT2ioU_6kj4X1k1CL7rQ",
          appId: "1:643238916979:web:dbfa75568d111540830b06",
          messagingSenderId: "643238916979",
          projectId: "restroqr"));

  defaultRadius = 30.0;
  defaultAppButtonRadius = 30.0;
  defaultLoaderAccentColorGlobal = primaryColor;

  await initialize(aLocaleLanguageList: languageList());

  appStore.setMenuStyle(getStringAsync(SharePreferencesKey.MENU_STYLE,
      defaultValue: AppConstant.defaultMenuStyle));
  appStore.setQrStyle(getStringAsync(SharePreferencesKey.QR_STYLE,
      defaultValue: AppConstant.defaultQrStyle.styleName!));
  appStore.setLanguage(getStringAsync(SharePreferencesKey.Language,
      defaultValue: AppConstant.defaultLanguage));

  appStore.setLoggedIn(getBoolAsync(SharePreferencesKey.IS_LOGGED_IN));
  if (appStore.isLoggedIn) {
    appStore.setUserId(getStringAsync(SharePreferencesKey.USER_ID));
    appStore.setFullName(getStringAsync(SharePreferencesKey.USER_NAME));
    appStore.setUserEmail(getStringAsync(SharePreferencesKey.USER_EMAIL));
    appStore.setUserProfile(getStringAsync(SharePreferencesKey.USER_IMAGE));
    appStore.setIsTester(getBoolAsync(SharePreferencesKey.IS_TESTER),
        isInitializing: true);
  }

  if (!isWeb) {
    int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
    if (themeModeIndex == AppThemeMode.ThemeModeLight) {
      appStore.setDarkMode(false);
    } else if (themeModeIndex == AppThemeMode.ThemeModeDark) {
      appStore.setDarkMode(true);
    }
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
      future: getMaterialYouData(),
      builder: (context, snap) {
        return Observer(
          builder: (_) => MaterialApp(
            scrollBehavior: SBehavior(),
            navigatorKey: navigatorKey,
            title: AppConstant.appName,
            debugShowCheckedModeBanner: false,
            theme: snap.hasData ? AppTheme.lightTheme : null,
            darkTheme: snap.hasData ? AppTheme.darkTheme : null,
            themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            home: SplashScreen(),
            onGenerateRoute: (settings) {
              List<String> pathComponents = settings.name!.split('/');
              if (pathComponents[1].isNotEmpty) {
                return MaterialPageRoute(
                  builder: (context) =>
                      UserSplashScreen(result: pathComponents[1]),
                  settings: RouteSettings(
                    name: '/${pathComponents[1]}',
                  ),
                );
              }
            },
            supportedLocales: LanguageDataModel.languageLocales(),
            localizationsDelegates: [
              AppLocalizations(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) => locale,
            locale: Locale(appStore.selectedLanguage
                .validate(value: AppConstant.defaultLanguage)),
          ),
        );
      },
    );
  }
}
