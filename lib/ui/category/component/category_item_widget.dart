import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_new_componentItem.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/ui/category/add_category_screen.dart';
import 'package:qr_menu/ui/category/component/category_list_view.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/get_style_widget.dart';

class CategoryItemWidget extends StatefulWidget {
  final List<CategoryModel> categories;
  final bool isAdmin;

  CategoryItemWidget({required this.categories, required this.isAdmin});

  @override
  _CategoryItemWidgetState createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {
  int selectedIndex = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            getCategoryTextWidget(widget.categories.length.validate()).expand(),
            if (widget.isAdmin)
              AddNewComponentItem(onTap: () {
                push(AddCategoryScreen());
              }),
          ],
        ).paddingSymmetric(horizontal: 16),
        8.height,
        if (widget.isAdmin)
          Text(
            language.lblLongPressOnCategoryForMoreOptions,
            style: secondaryTextStyle(size: 10),
          ).paddingSymmetric(horizontal: 16),
        16.height,
        Container(
          width: context.width(),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    selectedIndex = -1;
                    menuStore.setSelectedCategoryData(null);
                    appStore.setIsAll(true);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: radius(defaultRadius),
                      color: selectedIndex == -1
                          ? appStore.isDarkMode
                              ? Colors.white24
                              : primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 66,
                          width: 66,
                          decoration: BoxDecoration(
                            color: context.cardColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text("${language.lblA}",
                                  style: boldTextStyle(size: 24))
                              .center(),
                        ),
                        Text(
                          language.lblAll,
                          style: boldTextStyle(size: 14),
                          textAlign: TextAlign.center,
                        ).paddingSymmetric(horizontal: 8, vertical: 8)
                      ],
                    ),
                  ),
                ).paddingSymmetric(vertical: 8),
                CategoryListView(
                  categories: widget.categories,
                  selectedIndex: selectedIndex,
                  isAdmin: widget.isAdmin,
                  onCategoryChanged: (index) {
                    selectedIndex = index;
                    setState(() {});
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),
        ),
      ],
    );
  }
}
