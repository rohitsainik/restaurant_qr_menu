import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:qr_menu/components/add_new_componentItem.dart';
import 'package:qr_menu/components/no_data_component.dart';
import 'package:qr_menu/main.dart';
import 'package:qr_menu/models/restaurant_model.dart';
import 'package:qr_menu/ui/restaurant/add_restaurant_screen.dart';
import 'package:qr_menu/ui/restaurant/component/resturant_card_component.dart';
import 'package:qr_menu/ui/settings/setting_screen.dart';
import 'package:qr_menu/utils/constants.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(() {
      setStatusBarColor(context.scaffoldBackgroundColor);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Scaffold(
        appBar: appBarWidget("${language.lblHello}, ${appStore.userFullName}",
            showBack: false,
            elevation: 0,
            actions: [
              IconButton(
                onPressed: () {
                  push(SettingScreen(),
                      pageRouteAnimation: PageRouteAnimation.Scale,
                      duration: 450.milliseconds);
                },
                icon: Icon(Icons.settings, color: context.iconColor),
              ),
            ],
            color: context.scaffoldBackgroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              16.height,
              Row(
                children: [
                  StreamBuilder(
                    stream: restaurantOwnerService.getLength(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        return Text(
                          '${language.lblMyItems} (${snap.data.toString()})',
                          style: boldTextStyle(size: 18),
                        );
                      }
                      return snapWidgetHelper(snap, loadingWidget: Offstage());
                    },
                  ).expand(),
                  AddNewComponentItem(onTap: () {
                    push(AddRestaurantScreen(
                        userId: getStringAsync(SharePreferencesKey.USER_ID)));
                  })
                ],
              ),
              16.height,
              StreamBuilder<List<RestaurantModel>>(
                stream: restaurantOwnerService.getRestaurantData(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    if (snap.data!.length <= 0) {
                      return NoRestaurantComponent(
                          errorName: "${language.lblNoRestaurant}");
                    }
                    return Responsive(
                      mobile: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 40),
                        itemCount: snap.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurantCardComponent(
                                  data: snap.data![index])
                              .paddingSymmetric(vertical: 8);
                        },
                      ),
                      web: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return RestaurantCardComponent(
                                  data: snap.data![index])
                              .paddingSymmetric(vertical: 8);
                        },
                        itemCount: snap.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 2,
                          mainAxisExtent: 250,
                        ),
                        shrinkWrap: true,
                      ),
                    );
                  } else {
                    return snapWidgetHelper(snap);
                  }
                },
              )
            ],
          ).paddingSymmetric(horizontal: 16),
        ),
      ),
    );
  }
}
