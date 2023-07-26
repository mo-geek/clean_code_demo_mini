import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawytask/core/common_widgets/elevated_button.dart';
import 'package:nawytask/core/theme/custom_button_style.dart';
import 'package:nawytask/core/theme/custom_text_style.dart';
import 'package:nawytask/core/utils/handlers/image_constant.dart';
import 'package:nawytask/core/utils/handlers/size_utils.dart';
import 'package:nawytask/core/widgets/custom_elevated_button.dart';
import 'package:nawytask/core/widgets/custom_image_view.dart';
import 'package:nawytask/core/widgets/custom_search_view.dart';
import 'package:nawytask/features/search/presentation/pages/properties_view.dart';
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
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    tooltip: 'Show Snackbar',
                    onPressed: () {},
                  ),
                  Text('Search',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400))
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.0),
                            child: Text(' Price '),
                          ),
                        ],
                      ),
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: const Text(' Rooms '),
                          ),
                        ],
                      ),
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
                        onTap: () {
                          model.showResults();
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
