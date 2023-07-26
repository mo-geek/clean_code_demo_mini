import 'package:flutter/material.dart';
import 'package:nawytask/core/theme/app_decoration.dart';
import 'package:nawytask/core/theme/custom_button_style.dart';
import 'package:nawytask/core/theme/custom_text_style.dart';
import 'package:nawytask/core/theme/theme_helper.dart';
import 'package:nawytask/core/utils/handlers/image_constant.dart';
import 'package:nawytask/core/utils/handlers/size_utils.dart';
import 'package:nawytask/core/widgets/custom_elevated_button.dart';
import 'package:nawytask/core/widgets/custom_icon_button.dart';
import 'package:nawytask/core/widgets/custom_image_view.dart';
import 'package:nawytask/core/widgets/custom_outlined_button.dart';
import 'package:nawytask/features/search/data/model/property_model.dart';

class PropertiesView extends StatefulWidget {
  PropertyModel? propertyModel;
  PropertiesView({Key? key, this.propertyModel}) : super(key: key);

  @override
  State<PropertiesView> createState() => _PropertiesViewState();
}

class _PropertiesViewState extends State<PropertiesView> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    PropertyModel? propertyModel = widget.propertyModel;
    return SizedBox(
        height: getVerticalSize(655),
        width: double.maxFinite,
        child: Stack(alignment: Alignment.center, children: [
          Align(
              alignment: Alignment.topCenter,
              child: Container(
                  height: getVerticalSize(523),
                  width: double.maxFinite,
                  decoration: BoxDecoration(color: appTheme.gray100))),
          Align(
              alignment: Alignment.center,
              child: Container(
                  padding: getPadding(left: 14, top: 15, right: 14, bottom: 15),
                  decoration: AppDecoration.fill2,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                            padding: getPadding(left: 10),
                            child: Text(
                                "${propertyModel?.totalProperties ?? "none"} results",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: CustomTextStyles.bodySmallBlack900_1
                                    .copyWith(
                                        letterSpacing:
                                            getHorizontalSize(0.4)))),
                        // properties Card List
                        Expanded(
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _scrollController,
                              itemCount: propertyModel?.values?.length ?? 0,
                              itemBuilder: (context, index) {
                                return PropertyCard(
                                  val: propertyModel?.values?[index],
                                );
                              }),
                        ),
                        CustomIconButton(
                            onTap: () {
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            },
                            height: 48,
                            width: 48,
                            margin: getMargin(top: 19, bottom: 75),
                            padding: getPadding(all: 11),
                            alignment: Alignment.center,
                            child: CustomImageView(
                                svgPath: ImageConstant.imgArrowup))
                      ])))
        ]));
  }
}

class PropertyCard extends StatelessWidget {
  PropertyInfo? val;
  PropertyCard({Key? key, required this.val}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SizedBox(
            width: double.maxFinite,
            child: Container(
                margin: getMargin(top: 20),
                decoration: AppDecoration.white
                    .copyWith(borderRadius: BorderRadiusStyle.roundedBorder16),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: getVerticalSize(174),
                          width: getHorizontalSize(332),
                          child:
                              Stack(alignment: Alignment.topRight, children: [
                            CustomImageView(
                                placeHolder: ImageConstant.imageNotFound,
                                imagePath:
                                    val?.image ?? ImageConstant.imgRectangle373,
                                height: getVerticalSize(174),
                                width: getHorizontalSize(332),
                                alignment: Alignment.center),
                            Align(
                                alignment: Alignment.topRight,
                                child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 0,
                                    margin: getMargin(right: 16),
                                    color: theme.colorScheme.onPrimaryContainer,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadiusStyle.customBorderBL8),
                                    child: Container(
                                        height: getSize(64),
                                        width: getSize(64),
                                        padding: getPadding(
                                            left: 8,
                                            top: 22,
                                            right: 8,
                                            bottom: 22),
                                        decoration: AppDecoration.fill.copyWith(
                                            borderRadius: BorderRadiusStyle
                                                .customBorderBL8),
                                        child: Stack(children: [
                                          CustomImageView(
                                              imagePath: ImageConstant.imgLogo,
                                              height: getVerticalSize(20),
                                              width: getHorizontalSize(48),
                                              alignment: Alignment.center)
                                        ]))))
                          ])),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(left: 16, top: 11, right: 16),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${val?.propertyType?.name ?? "----"}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.titleMedium),
                                    Text(
                                        "Delivery ${val?.maxInstallmentYears ?? "not specified"}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: CustomTextStyles
                                            .bodyLargeErrorContainer)
                                  ]))),
                      Align(
                          alignment: Alignment.center,
                          child: Padding(
                              padding: getPadding(left: 16, top: 11, right: 16),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        "${val?.currency ?? "EGP"} ${val?.maxPrice ?? "not specified"}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: CustomTextStyles
                                            .titleLargeOrangeA700),
                                    Container(
                                        margin: getMargin(left: 30),
                                        child: CustomImageView(
                                            svgPath: ImageConstant
                                                .imgFavoriteBorder))
                                  ]))),
                      Padding(
                          padding: getPadding(left: 16, top: 8),
                          child: Row(children: [
                            Text(
                                "${val?.minInstallments ?? "not specified"} EGP/month",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style:
                                    CustomTextStyles.bodyMediumErrorContainer),
                            Padding(
                                padding: getPadding(left: 4),
                                child: Text(
                                    "over ${val?.maxInstallmentYears ?? "not specified"} years ",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyles
                                        .bodyMediumErrorContainer))
                          ])),
                      Padding(
                          padding: getPadding(left: 16, top: 11),
                          child: Text(
                              "${val?.compound?.name ?? "not specified"}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyLarge)),
                      Padding(
                          padding: getPadding(left: 16, top: 9),
                          child: Text("${val?.area?.name ?? "not specified"}",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: theme.textTheme.bodyLarge)),
                      Container(
                          margin: getMargin(top: 9),
                          padding: getPadding(
                              left: 56, top: 12, right: 56, bottom: 12),
                          decoration: AppDecoration.fill3,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                    svgPath: ImageConstant.imgBed,
                                    height: getSize(24),
                                    width: getSize(24)),
                                Padding(
                                    padding:
                                        getPadding(left: 8, top: 3, bottom: 3),
                                    child: Text(
                                        "${val?.numberOfBedrooms ?? "not specified"}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodyMedium)),
                                CustomImageView(
                                    svgPath: ImageConstant.imgBath,
                                    height: getSize(24),
                                    width: getSize(24),
                                    margin: getMargin(left: 16)),
                                Padding(
                                    padding:
                                        getPadding(left: 8, top: 3, bottom: 3),
                                    child: Text(
                                        "${val?.numberOfBathrooms ?? "--"}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodyMedium)),
                                CustomImageView(
                                    svgPath: ImageConstant.imgArea,
                                    height: getSize(24),
                                    width: getSize(24),
                                    margin: getMargin(left: 16)),
                                Padding(
                                    padding:
                                        getPadding(left: 5, top: 3, bottom: 3),
                                    child: Text(
                                        "${val?.minUnitArea ?? "not specified"}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: theme.textTheme.bodyMedium)),
                                Padding(
                                    padding:
                                        getPadding(left: 5, top: 1, bottom: 5),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "m",
                                              style:
                                                  theme.textTheme.bodyMedium),
                                          TextSpan(
                                              text: "2",
                                              style: theme.textTheme.bodyMedium)
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Container(
                          margin: getMargin(top: 10),
                          decoration: AppDecoration.fill,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: CustomOutlinedButton(
                                        text: "Zoom",
                                        margin: getMargin(right: 4, bottom: 16),
                                        leftIcon: Container(
                                            margin: getMargin(right: 10),
                                            decoration: BoxDecoration(
                                                color: appTheme.lightBlue800),
                                            child: CustomImageView(
                                                svgPath: ImageConstant
                                                    .imgVideocamera)),
                                        buttonStyle: CustomButtonStyles
                                            .outlineLightblue800
                                            .copyWith(
                                                fixedSize: MaterialStateProperty
                                                    .all<Size>(Size(
                                                        double.maxFinite,
                                                        getVerticalSize(32)))),
                                        buttonTextStyle:
                                            theme.textTheme.labelLarge!)),
                                Expanded(
                                    child: CustomOutlinedButton(
                                        text: "Call",
                                        margin: getMargin(
                                            left: 4, right: 4, bottom: 16),
                                        leftIcon: Container(
                                            margin: getMargin(right: 10),
                                            child: CustomImageView(
                                                svgPath:
                                                    ImageConstant.imgCall)),
                                        buttonStyle: CustomButtonStyles
                                            .outlineLightblue800
                                            .copyWith(
                                                fixedSize: MaterialStateProperty
                                                    .all<Size>(Size(
                                                        double.maxFinite,
                                                        getVerticalSize(32)))),
                                        buttonTextStyle:
                                            theme.textTheme.labelLarge!)),
                                Expanded(
                                    child: CustomOutlinedButton(
                                        text: "Whatsapp",
                                        margin: getMargin(left: 4, bottom: 16),
                                        leftIcon: Container(
                                            margin: getMargin(right: 10),
                                            child: CustomImageView(
                                                svgPath:
                                                    ImageConstant.imgFrame)),
                                        buttonStyle: CustomButtonStyles
                                            .outlineLightblue800
                                            .copyWith(
                                                fixedSize: MaterialStateProperty
                                                    .all<Size>(Size(
                                                        double.maxFinite,
                                                        getVerticalSize(32)))),
                                        buttonTextStyle:
                                            theme.textTheme.labelLarge!))
                              ]))
                    ]))));
  }
}
