import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/ui/auth/sign_in_screen.dart';
import 'package:qr_menu/utils/constants.dart';

class WalkThroughContainer1 extends StatefulWidget {
  @override
  _WalkThroughContainer1State createState() => _WalkThroughContainer1State();
}

class _WalkThroughContainer1State extends State<WalkThroughContainer1> {
  bool button = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            50.height,
            Image.asset(AppImages.paperLess, height: 300, width: 300).cornerRadiusWithClipRRect(16),
            64.height,
            Text(language.lblGoPaperless.toUpperCase(), style: boldTextStyle(size: 20)),
            16.height,
            Text(
              language.lblGoPaperlessWithOurDigitalMenu,
              style: secondaryTextStyle(),
              textAlign: TextAlign.center,
            ).paddingSymmetric(horizontal: 16),
            AppButton(
              child: Icon(Icons.arrow_forward),
              onTap: () {
                setValue(SharePreferencesKey.IS_WALKED_THROUGH, true);
                SignInScreen().launch(context);
              },
              color: Colors.white.withOpacity(0.5),
            ).visible(button),
          ],
        ),
      ),
    );
  }
}
