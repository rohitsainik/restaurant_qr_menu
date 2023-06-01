import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/ui/category/add_category_screen.dart';

class MenuCategoryLisComponentStyleTwo extends StatelessWidget {
  final CategoryModel categoryData;
  final bool isAdmin;

  MenuCategoryLisComponentStyleTwo({required this.categoryData, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (isAdmin) {
              AddCategoryScreen(categoryData: categoryData).launch(context);
            }
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(border: Border.all(color: context.dividerColor, width: 3)),
                child: Text(
                  categoryData.name.validate(),
                  style: boldTextStyle(size: 20, fontFamily: GoogleFonts.aclonica().fontFamily),
                ),
              ),
              Container(
                transform: new Matrix4.identity()..rotateZ(8 * 3.14 / 180),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all(color: context.dividerColor, width: 3)),
                child: Text(categoryData.name.validate(), style: boldTextStyle(size: 21, color: Colors.transparent)),
              )
            ],
          ).center(),
        ),
        16.height
      ],
    );
  }
}
