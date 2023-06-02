import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/utils/cached_network_image.dart';

class QrComponentStyleOne extends StatelessWidget {
  final GlobalKey qrKey;
  final String saveUrl;
  final bool isTesting;

  QrComponentStyleOne(
      {required this.isTesting, required this.qrKey, required this.saveUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width() - 32,
      decoration:
          BoxDecoration(borderRadius: radius(16), color: context.cardColor),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            (selectedRestaurant.logoImage.isEmptyOrNull)
                ? Offstage()
                : cachedImage(
                    selectedRestaurant.logoImage,
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ).cornerRadiusWithClipRRect(80),
            Text(
              "${selectedRestaurant.name.validate()}",
              textAlign: TextAlign.center,
              style: boldTextStyle(
                size: 36,
              ),
            ),
            16.height,
            Text(language.lblScanForOurOnlineMenu,
                textAlign: TextAlign.center, style: primaryTextStyle(size: 20)),
            16.height,
            RepaintBoundary(
              key: qrKey,
              child: QrImageView(
                version: 4,
                data: isTesting ? selectedRestaurant.uid.validate() : saveUrl,
                size: 250,
                backgroundColor: Colors.white,
                errorStateBuilder: (cxt, err) {
                  return Container(
                    child: Center(
                      child: Text("${language.lblUhOhSomethingWentWrong}",
                          textAlign: TextAlign.center),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ).center();
  }
}
