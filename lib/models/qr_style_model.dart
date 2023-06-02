import 'package:qr_menu/main.dart';

class QrStyleModel {
  String? styleName;

  QrStyleModel({this.styleName});

  static List<QrStyleModel> getQrStyleList() {
    List<QrStyleModel> data = [];
    data.add(QrStyleModel(styleName: language.lblQrStyle1));
    data.add(QrStyleModel(styleName: language.lblQrStyle2));
    data.add(QrStyleModel(styleName: language.lblQrStyle3));

    return data;
  }
}
