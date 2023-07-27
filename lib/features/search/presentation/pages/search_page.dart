import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nawytask/core/theme/custom_button_style.dart';
import 'package:nawytask/core/theme/custom_text_style.dart';
import 'package:nawytask/core/theme/theme_helper.dart';
import 'package:nawytask/core/utils/handlers/image_constant.dart';
import 'package:nawytask/core/utils/handlers/size_utils.dart';
import 'package:nawytask/core/widgets/custom_elevated_button.dart';
import 'package:nawytask/core/widgets/custom_image_view.dart';
import 'package:nawytask/core/widgets/custom_search_view.dart';
import 'package:nawytask/features/search/presentation/pages/search_results_page.dart';
import 'package:nawytask/features/search/presentation/providers/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(),
      onViewModelReady: (SearchViewModel vm) async {
        await vm.init();
      },
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leadingWidth: 150,
            leading: SizedBox(
              width: 150,
              child: Row(
                children: [
                  CustomImageView(
                    svgPath: ImageConstant.imgArrowleft,
                    height: getSize(29),
                    width: getSize(29),
                    margin: getMargin(bottom: 2, left: 11),
                  ),
                  Padding(
                      padding: getPadding(left: 9, bottom: 2, right: 11),
                      child: Text("Search",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: theme.textTheme.titleLarge!.copyWith(
                              letterSpacing: getHorizontalSize(0.15)))),
                ],
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  CustomSearchView(
                      margin: getMargin(left: 8, right: 8),
                      controller: model.searchController,
                      hintText: "Area, Compound, Developer",
                      hintStyle: CustomTextStyles.bodyLargeBlack900,
                      textStyle: CustomTextStyles.bodyLargeBlack900,
                      prefix: Container(
                          margin: getMargin(
                              left: 16, top: 16, right: 12, bottom: 16),
                          child: CustomImageView(
                              svgPath: ImageConstant.imgSearch)),
                      prefixConstraints:
                          BoxConstraints(maxHeight: getVerticalSize(56)),
                      suffix: Padding(
                          padding:
                              EdgeInsets.only(right: getHorizontalSize(15)),
                          child: IconButton(
                              onPressed: () {
                                model.searchController.clear();
                              },
                              icon: Icon(Icons.clear,
                                  color: Colors.grey.shade600))),
                      contentPadding:
                          getPadding(top: 18, right: 52, bottom: 18)),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Padding(
                          padding: getPadding(left: 8, top: 5, right: 9),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Price",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyles.bodyLargeBlack900_1
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.15))),
                                Padding(
                                    padding:
                                        getPadding(top: 2, bottom: 1, left: 5),
                                    child: Text(
                                        "From : ${model.selectedMinPrice} ~ To: ${model.selectedMaxPrice}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.4))))
                              ])),
                      RangeSlider(
                          values: model.selectedPriceRange,
                          min: model.minPrice,
                          max: model.maxPrice,
                          divisions: model.divisionPrice,
                          onChanged: (RangeValues v) {
                            model.setPriceRange(v);
                          }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    children: [
                      Padding(
                          padding: getPadding(left: 8, top: 5, right: 9),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Rooms",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyles.bodyLargeBlack900_1
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.15))),
                                Padding(
                                    padding: getPadding(top: 2, bottom: 1),
                                    child: Text(
                                        "${model.selectedMinRooms} ~ ${model.selectedMaxRooms}+ rooms",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodySmall!
                                            .copyWith(
                                                letterSpacing:
                                                    getHorizontalSize(0.4))))
                              ])),
                      RangeSlider(
                          values: model.selectedBedRoomsRange,
                          min: model.minBedRooms,
                          max: model.maxBedRooms,
                          divisions: model.divisionBedRooms,
                          onChanged: (RangeValues v) {
                            model.setRoomRange(v);
                          }),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85.0),
                    child: CustomElevatedButton(
                        onTap: () async {
                          await model.showResults();
                          FocusScope.of(context).unfocus();
                          if (model.propertyModel != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SearchResultsView(
                                      propertyModel: model.propertyModel)),
                            );
                          }
                        },
                        text: "Show results".toUpperCase(),
                        margin: getMargin(top: 51, bottom: 30),
                        buttonStyle: CustomButtonStyles.fillLightblue800
                            .copyWith(
                                fixedSize: MaterialStateProperty.all<Size>(Size(
                                    getHorizontalSize(165),
                                    getVerticalSize(36)))),
                        buttonTextStyle:
                            CustomTextStyles.titleSmallOnPrimaryContainer),
                  ),
                  const SizedBox(height: 16),
                  // Display the search results here (e.g., in a GridView or ListView)
                  // model.results can be used to access the search results
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
