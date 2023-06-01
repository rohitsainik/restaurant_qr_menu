import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/ui/category/add_category_screen.dart';
import 'package:qr_menu/ui/category/component/category_widget.dart';

class CategoryListView extends StatefulWidget {
  final List<CategoryModel> categories;
  final bool isAdmin;
  final Function(int) onCategoryChanged;
  final int selectedIndex;

  CategoryListView({required this.categories, required this.onCategoryChanged, required this.isAdmin, required this.selectedIndex});

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return HorizontalList(
      physics: NeverScrollableScrollPhysics(),
      spacing: 4,
      itemCount: widget.categories.length,
      itemBuilder: (context, index) {
        CategoryModel categoryData = widget.categories[index];
        bool isSelected = widget.selectedIndex == index;

        return GestureDetector(
          onTap: () {
            appStore.setIsAll(false);
            widget.onCategoryChanged.call(index);
            menuStore.setSelectedCategoryData(widget.categories[index]);
            setState(() {});
          },
          onLongPress: () {
            if (widget.isAdmin) {
              AddCategoryScreen(categoryData: categoryData).launch(context);
            }
          },
          child: CategoryWidget(categoryData: categoryData, isSelected: isSelected),
        );
      },
    );
  }
}
