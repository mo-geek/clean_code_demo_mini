import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nawytask/core/common_widgets/MaterialIndicator.dart';
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
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                  Text('Results',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25.0,
                          fontWeight: FontWeight.w400))
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.filter_alt,
                  color: Colors.black45,
                ),
                tooltip: 'Show Snackbar',
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black45,
                ),
                tooltip: 'Show Snackbar',
                onPressed: () {},
              )
            ],
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Properties",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
                Tab(
                  child: Text(
                    "Compounds",
                    style: TextStyle(fontSize: 25.0),
                  ),
                ),
              ],
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
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
