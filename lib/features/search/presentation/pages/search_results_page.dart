import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nawytask/core/common_widgets/MaterialIndicator.dart';
import 'package:nawytask/core/theme/custom_text_style.dart';
import 'package:nawytask/core/theme/theme_helper.dart';
import 'package:nawytask/core/utils/handlers/image_constant.dart';
import 'package:nawytask/core/utils/handlers/size_utils.dart';
import 'package:nawytask/core/widgets/custom_image_view.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';
import 'package:nawytask/features/search/presentation/pages/compounds_view.dart';
import 'package:nawytask/features/search/presentation/pages/properties_view.dart';

class SearchResultsView extends StatefulWidget {
  PropertyModel? propertyModel;
  SearchResultsView({Key? key, this.propertyModel}) : super(key: key);

  @override
  _SearchResultsViewState createState() => _SearchResultsViewState();
}

class _SearchResultsViewState extends State<SearchResultsView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 150,
            leading: SizedBox(
              width: 170,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomImageView(
                      svgPath: ImageConstant.imgArrowleft,
                      height: getSize(29),
                      width: getSize(29),
                      margin: getMargin(bottom: 2, left: 11),
                    ),
                  ),
                  Padding(
                      padding: getPadding(left: 9, bottom: 2, right: 11),
                      child: Text("Results",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.titleLarge!.copyWith(
                              letterSpacing: getHorizontalSize(0.15)))),
                ],
              ),
            ),
            actions: <Widget>[
              CustomImageView(
                  svgPath: ImageConstant.imgFilteralt,
                  height: getSize(24),
                  width: getSize(24),
                  margin: getMargin(bottom: 2)),
              CustomImageView(
                  svgPath: ImageConstant.imgSort,
                  height: getSize(24),
                  width: getSize(24),
                  margin: getMargin(left: 24, bottom: 2)),
              SizedBox(
                width: 11,
              )
            ],
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Properties".toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                Tab(
                  child: Text("Compounds".toUpperCase(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left),
                ),
              ],
              labelColor: appTheme.lightBlue800,
              unselectedLabelColor: appTheme.blueGray400,
              indicator: MaterialIndicator(
                  height: 1,
                  tabPosition: TabPosition.bottom,
                  color: Colors.blue),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            PropertiesView(propertyModel: widget.propertyModel),
            CompoundsView()
          ],
        ),
      ),
    );
  }
}
