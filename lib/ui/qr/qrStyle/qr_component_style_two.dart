import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_menu/main.dart';

class QrComponentStyleTwo extends StatelessWidget {
  final GlobalKey qrKey;
  final String saveUrl;
  final bool isTesting;

  QrComponentStyleTwo({required this.isTesting, required this.qrKey, required this.saveUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 32, left: 16, right: 16, top: 32),
      width: context.width() - 32,
      decoration: boxDecorationDefault(
        borderRadius: radius(16),
        color: context.cardColor,
        border: Border.all(color: context.dividerColor, width: 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: qrKey,
            child: QrImageView(
              version: 4,
              eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle),
              dataModuleStyle: QrDataModuleStyle(dataModuleShape: QrDataModuleShape.circle),
              data: isTesting ? selectedRestaurant.uid.validate() : saveUrl,
              size: 250,
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              errorStateBuilder: (cxt, err) {
                return Container(
                  child: Center(
                    child: Text("${language.lblUhOhSomethingWentWrong}", textAlign: TextAlign.center),
                  ),
                );
              },
            ),
          ),
          16.height,
          Text(language.lblScanForOurOnlineMenu, textAlign: TextAlign.center, style: primaryTextStyle(size: 20)),
          16.height,
          Text("${selectedRestaurant.name.validate()}", textAlign: TextAlign.center, style: boldTextStyle(size: 36)),
        ],
      ),
    ).center();
  }
}
