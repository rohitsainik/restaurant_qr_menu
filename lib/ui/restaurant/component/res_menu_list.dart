import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_new_componentItem.dart';
import 'package:qr_menu/components/no_data_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/models/menu_category_model.dart';
import 'package:qr_menu/ui/category/component/category_component.dart';
import 'package:qr_menu/ui/menu/add_menu_item_screen.dart';
import 'package:qr_menu/utils/get_style_widget.dart';

class ResMenuList extends StatefulWidget {
  final bool isAdmin;

  ResMenuList({this.isAdmin = false});

  @override
  _ResMenuListState createState() => _ResMenuListState();
}

class _ResMenuListState extends State<ResMenuList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    menuStore.setSelectedCategoryData(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Container(
        height: context.height(),
        width: context.width(),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 60, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CategoryComponent(isAdmin: widget.isAdmin),
              16.height,
              Row(
                children: [
                  Text(language.lblMenuItems, style: boldTextStyle(size: 20)).expand(),
                  if (widget.isAdmin)
                    AddNewComponentItem(onTap: () {
                      push(AddMenuItemScreen()).then((value) {
                        setState(() {});
                      });
                    }),
                ],
              ).paddingSymmetric(horizontal: 16),
              16.height,
              Stack(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (_, index) {
                      MenuCategoryModel data = appStore.menuListByCategory[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<CategoryModel>(
                            stream: categoryService.getSingleStreamData(uId: data.categoryId.validate()),
                            builder: (context, snap) {
                              if (snap.hasData) {
                                return getMenuCategoryListWidget(snap.data!, widget.isAdmin);
                              }
                              return snapWidgetHelper(snap);
                            },
                          ),
                          GetMenuComponentWidget(data: data, isAdmin: widget.isAdmin)
                        ],
                      ).paddingSymmetric(horizontal: 8, vertical: 8);
                    },
                    shrinkWrap: true,
                    itemCount: appStore.isAll ? appStore.menuListByCategory.length : appStore.menuListByCategory.take(1).length,
                  ),
                  NoMenuComponent(
                    categoryName: menuStore.selectedCategoryData?.name.validate(),
                  ).center().visible(appStore.menuListByCategory.isEmpty && !appStore.isLoading),
                  Loader().center().visible(appStore.isLoading),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
