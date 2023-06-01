import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/ui/category/component/category_item_widget.dart';

class CategoryComponent extends StatelessWidget {
  final bool isAdmin;

  CategoryComponent({this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CategoryModel>>(
      stream: categoryService.getCategoryStreamData(),
      builder: (context, snap) {
        if (snap.hasData) {
          return CategoryItemWidget(isAdmin: isAdmin, categories: snap.data!);
        }
        return snapWidgetHelper(snap);
      },
    );
  }
}
