import 'package:flutter/material.dart';
import 'package:nawytask/core/theme/app_decoration.dart';
import 'package:nawytask/core/theme/custom_text_style.dart';
import 'package:nawytask/core/theme/theme_helper.dart';
import 'package:nawytask/core/utils/handlers/image_constant.dart';
import 'package:nawytask/core/utils/handlers/size_utils.dart';
import 'package:nawytask/core/widgets/custom_image_view.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgSearchOrangeA700,
      activeIcon: ImageConstant.imgSearchOrangeA700,
      title: "Explore",
      type: BottomBarEnum.Explore,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgDashboardicon,
      activeIcon: ImageConstant.imgDashboardicon,
      title: "Updates",
      type: BottomBarEnum.Updates,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgFollowicon,
      activeIcon: ImageConstant.imgFollowicon,
      title: "Favorites",
      type: BottomBarEnum.Favorites,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgOverflowmenu,
      activeIcon: ImageConstant.imgOverflowmenu,
      title: "More",
      type: BottomBarEnum.More,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            getHorizontalSize(
              6,
            ),
          ),
          topRight: Radius.circular(
            getHorizontalSize(
              6,
            ),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              0,
              -2,
            ),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Container(
              padding: getPadding(
                left: 21,
                top: 7,
                right: 21,
                bottom: 7,
              ),
              decoration: AppDecoration.fill,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageView(
                    svgPath: bottomMenuList[index].icon,
                    height: getSize(
                      24,
                    ),
                    width: getSize(
                      24,
                    ),
                    color: appTheme.black900,
                    margin: getMargin(
                      top: 8,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 1,
                      bottom: 7,
                    ),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: theme.textTheme.bodySmall!.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.4,
                        ),
                        color: appTheme.black900.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            activeIcon: Container(
              padding: getPadding(
                left: 24,
                top: 7,
                right: 24,
                bottom: 7,
              ),
              decoration: AppDecoration.fill.copyWith(
                borderRadius: BorderRadiusStyle.customBorderTL6,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomImageView(
                    svgPath: bottomMenuList[index].activeIcon,
                    height: getSize(
                      24,
                    ),
                    width: getSize(
                      24,
                    ),
                    color: appTheme.orangeA700,
                    margin: getMargin(
                      top: 8,
                    ),
                  ),
                  Padding(
                    padding: getPadding(
                      top: 1,
                      bottom: 7,
                    ),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: CustomTextStyles.bodySmallOrangeA700.copyWith(
                        letterSpacing: getHorizontalSize(
                          0.4,
                        ),
                        color: appTheme.orangeA700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Explore,
  Updates,
  Favorites,
  More,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
