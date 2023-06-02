import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/models/qr_style_model.dart';

const mBaseURL = 'https://myrestroqr.com/';
const mCodeCanyonURL = '';

const useMaterialYouTheme = true;

class AppConstant {
  static const appName = "MY Restro Qr";
  static const appDescription =
      'QR Menu is a well equipped Flutter app. On the user end, it offers the user a simple way to view the menu of a restaurant without even confronting the waiter. It offers an easy, manageable & on-the-go methodology of menu viewing process. While, on the restaurant owner end, the app offers a conventional and easily manageable method to manage restaurants, food categories and menus';
  static const defaultLanguage = 'en';
  static const defaultMenuStyle = "Menu Style 1";
  static QrStyleModel defaultQrStyle = QrStyleModel(styleName: "QR Style 1");
}

class AppThemeMode {
  static const ThemeModeLight = 1;
  static const ThemeModeDark = 2;
  static const ThemeModeSystem = 0;
}

class SharePreferencesKey {
  static const IS_LOGGED_IN = 'IS_LOGGED_IN';
  static const USER_ID = 'USER_ID';
  static const USER_NAME = 'USER_NAME';
  static const USER_NUMBER = 'USER_NUMBER';
  static const USER_EMAIL = 'USER_EMAIL';
  static const USER_IMAGE = 'USER_IMAGE';
  static const IS_EMAIL_LOGIN = 'IS_EMAIL_LOGIN';
  static const PASSWORD = "PASSWORD";
  static const Language = "Language";
  static const IS_TESTER = "isTester";

  static const IS_NOTIFICATION_ON = "IS_NOTIFICATION_ON";
  static const IS_WALKED_THROUGH = "IS_WALKED_THROUGH";

  static const MENU_STYLE = "MENU_STYLE";
  static const QR_STYLE = "QR_STYLE";
}

class AppImages {
  static const placeHolderImage = "images/place_holder.jpg";
  static const app_logo = "images/app_icon_dark.png";
  static const app_logo_dark = "images/app_icon.png";
  static const noDataImage = "images/no_data.png";
  static const empty_image_placeholder = "images/empty_image_placeholder.jpg";
  static const paperLess = "images/paper.png";
  static const language = "images/language.png";
  static const theme = "images/theme.png";
}

class MenuTypeName {
  static const news = "New";
  static const spicy = "Spicy";
  static const jain = "Jain";
  static const special = "Special";
  static const popular = "Popular";
  static const sweet = "Sweet";
}

class MenuTypeImage {
  static const newImage = "images/new1.png";
  static const spicyImage = "images/spicy1.png";
  static const jainImage = "images/jain.png";
  static const specialImage = "images/special1.png";
  static const popularImage = "images/popular1.png";
}

class Urls {
  static const appDescription = "";
  static const copyRight = 'copyright @editorschamber';
  static const packageName = "com.ed.myrestroqr";
  static const termsAndConditionURL =
      'https://wordpress.iqonic.design/docs/product/qr-menu/help-and-support/';
  static const supportURL = 'https://iqonic.desky.support/';
  static const codeCanyonURL =
      'https://codecanyon.net/item/restaurant-qr-menu-flutter-app-with-firebase-backend/34377503?s_rank=1';
  static const appShareURL = '$playStoreBaseURL$packageName';
  static const mailto = 'hello@iqonic.design';
  static const documentation =
      'https://wordpress.iqonic.design/docs/product/qrmenu/';
  static const privacyPolicyURL = 'https://iqonic.design/privacy/';
}

enum FileType { CANCEL, CAMERA, GALLERY }

enum MenuType { IS_NEW, IS_SPICY, IS_JAIN, IS_SPECIAL, IS_POPULAR }

enum RestaurantType { IS_VEG, IS_NON_VEG }

const LoginTypeApple = 'apple';

//region default USER login
const DEFAULT_EMAIL = 'demo@user.com';
const DEFAULT_PASS = '123456';
//endregion

const demoUserMessage = "Demo user cannot be granted for this action";
