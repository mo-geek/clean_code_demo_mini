import 'package:flutter/material.dart';
import 'package:nawytask/features/search/presentation/pages/search_page.dart';
import 'package:stacked/stacked.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StackedBottomNavViewModel>.reactive(
      viewModelBuilder: () => StackedBottomNavViewModel(),
      builder: (context, model, child) => Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            SearchView(),
            UpdateView(),
            FavouriteView(),
            MoreView(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, -2),
                blurRadius: 1.0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 3.0,
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.black54,
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Explore',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.update),
                label: 'Update',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favourite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.more_vert),
                label: 'More',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StackedBottomNavViewModel extends BaseViewModel {}

class UpdateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Update Screen',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class FavouriteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favourite Screen',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class MoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'More Screen',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
