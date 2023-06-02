import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/colors.dart';

class QrComponentStyleThree extends StatelessWidget {
  final GlobalKey qrKey;
  final String saveUrl;
  final bool isTesting;

  QrComponentStyleThree(
      {required this.isTesting, required this.qrKey, required this.saveUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 32),
      width: context.width(),
      decoration: boxDecorationDefault(
        borderRadius: radiusOnly(bottomRight: 200, bottomLeft: 200),
        color: context.scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          30.height,
          Text(
            language.lblScanForOurOnlineMenu,
            textAlign: TextAlign.center,
            style: primaryTextStyle(size: 16),
          ),
          16.height,
          RepaintBoundary(
              key: qrKey,
              child: QrImageView(
                padding: EdgeInsets.all(16),
                dataModuleStyle: QrDataModuleStyle(
                    dataModuleShape: QrDataModuleShape.circle),
                backgroundColor: appStore.isDarkMode
                    ? Colors.white
                    : primaryColor.withAlpha(20),
                version: 4,
                data: isTesting ? selectedRestaurant.uid.validate() : saveUrl,
                size: 220,
                foregroundColor: Colors.black,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text(
                        "${language.lblUhOhSomethingWentWrong}",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ).cornerRadiusWithClipRRect(defaultRadius)),
          16.height,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              (selectedRestaurant.logoImage.isEmptyOrNull)
                  ? Offstage()
                  : cachedImage(
                      selectedRestaurant.logoImage,
                      fit: BoxFit.cover,
                      width: 60,
                      height: 60,
                    ).cornerRadiusWithClipRRect(80),
              8.width,
              Text(
                "${selectedRestaurant.name.validate()}",
                textAlign: TextAlign.center,
                style: boldTextStyle(
                    size: 30,
                    fontFamily: GoogleFonts.gloriaHallelujah().fontFamily),
              ),
            ],
          ),
          60.height,
        ],
      ),
    );
  }
}
