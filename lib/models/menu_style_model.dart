class MenuStyleModel {
  String? styleName;

  MenuStyleModel({this.styleName});

  static List<MenuStyleModel> getStyleList() {
    List<MenuStyleModel> data = [];
    data.add(MenuStyleModel(styleName: 'Menu Style 1'));
    data.add(MenuStyleModel(styleName: 'Menu Style 2'));
    data.add(MenuStyleModel(styleName: 'Menu Style 3'));

    return data;
  }
}
