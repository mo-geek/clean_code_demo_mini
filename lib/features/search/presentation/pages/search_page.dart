import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nawytask/core/common_widgets/elevated_button.dart';
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
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text('Search', style: TextStyle(color: Colors.black)),
          leading: InkWell(
            onTap: () {
              //
            },
            child: Padding(
                padding: EdgeInsets.all(5.w),
                child: SvgPicture.asset(
                  'assets/icons/back_arrow.svg',
                  fit: BoxFit.scaleDown,
                  color: Colors.black,
                )),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                TextFormField(
                  initialValue: 'Areas, Compounds',
                  onChanged: model.onTextChanged,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
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
                SizedBox(
                  width: 100.0,
                  child: ElevatedButton(
                      onPressed: () {
                        model.showResults();
                        FocusScope.of(context).unfocus();
                      },
                      child: Text('SHOW RESULTS',
                          style: TextStyle(color: Colors.white)),
                      style: elevatedButtonStyle),
                ),
                const SizedBox(height: 16),
                // Display the search results here (e.g., in a GridView or ListView)
                // model.results can be used to access the search results
              ],
            ),
          ),
        ),
      ),
    );
  }
}
