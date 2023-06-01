import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/ui/category/add_category_screen.dart';

class MenuCategoryLisComponentStyleThree extends StatelessWidget {
  final CategoryModel categoryData;
  final bool isAdmin;

  MenuCategoryLisComponentStyleThree({required this.categoryData, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          categoryData.name.validate(),
          style: boldTextStyle(size: 20, fontFamily: GoogleFonts.gloriaHallelujah().fontFamily),
        ).onTap(() {
          if (isAdmin) {
            AddCategoryScreen(categoryData: categoryData).launch(context);
          }
        }),
        Image.asset('images/ic_line.png', width: 100, color: appStore.isDarkMode ? Colors.white : Colors.black),
        16.height,
      ],
    ).center();
  }
}
