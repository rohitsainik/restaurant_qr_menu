import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/category_model.dart';
import 'package:qr_menu/utils/cached_network_image.dart';
import 'package:qr_menu/utils/colors.dart';
import 'package:qr_menu/utils/common.dart';

class CategoryDropdownComponent extends StatefulWidget {
  final String? defaultValue;
  final Function(CategoryModel value) onValueChanged;
  final bool isValidate;

  CategoryDropdownComponent({this.defaultValue, required this.onValueChanged, required this.isValidate});

  @override
  _CategoryDropdownComponentState createState() => _CategoryDropdownComponentState();
}

class _CategoryDropdownComponentState extends State<CategoryDropdownComponent> {
  CategoryModel? selectedData;

  AsyncMemoizer<List<CategoryModel>> _asyncMemoizer = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryModel>>(
      future: _asyncMemoizer.runOnce(() => categoryService.getCategoryFutureData()),
      builder: (context, snap) {
        if (snap.hasData) {
          if (widget.defaultValue != null) {
            selectedData = snap.data!.firstWhere((element) => element.uid == widget.defaultValue);
            widget.onValueChanged.call(selectedData!);
          }
          return DropdownButtonFormField<CategoryModel>(
            onChanged: (value) {
              widget.onValueChanged.call(value!);
            },
            value: selectedData,
            isExpanded: true,
            validator: widget.isValidate
                ? (c) {
                    if (c == null) return errorThisFieldRequired;
                    return null;
                  }
                : null,
            decoration: inputDecoration(context, label: '${language.lblChooseCategory}').copyWith(
              prefixIcon: Icon(Icons.category_outlined, color: secondaryIconColor),
            ),
            dropdownColor: context.cardColor,
            alignment: Alignment.bottomCenter,
            items: List.generate(
              snap.data!.length,
              (index) {
                CategoryModel data = snap.data![index];
                return DropdownMenuItem(
                  value: data,
                  child: Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data.name.validate()}', style: primaryTextStyle()),
                        cachedImage(
                          data.image.validate(),
                          height: 25,
                          width: 25,
                          fit: BoxFit.cover,
                        ).cornerRadiusWithClipRRect(100),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return snapWidgetHelper(snap);
      },
    );
  }
}
