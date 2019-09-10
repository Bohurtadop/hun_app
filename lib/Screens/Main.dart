import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/Screens/Home.dart';
import 'package:hun_app/Screens/Profile.dart';
import 'package:hun_app/Screens/SetSpeciality.dart';
import 'package:hun_app/resources/Resources.dart';

class MainPage extends StatefulWidget {
  final int initialPage;

  MainPage({this.initialPage = 0});

  @override
  createState() => MainPageState();
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int _page;
  PageController _pageController;

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    this._page = widget.initialPage ?? 0;
    _pageController = PageController(initialPage: this._page);
    debugPrint(
      '[Main Page] Page controller has been initialized in page: $_page',
    );
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  BottomNavigationBarItem _newBarItem(
      {@required BuildContext context, String title, Widget icon}) {
    return BottomNavigationBarItem(
      backgroundColor: Color(0xff1266A4),
      title: Text(
        title ?? '',
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.width / 28,
          fontFamily: 'Ancízar Sans Regular',
        ),
      ),
      icon: icon ?? Icon(Icons.android),
    );
  }

  void _onPageChanged(int page) {
    setState(() => _page = page);
    debugPrint('[MainPage] Current page: $page');
  }

  void _onBottomItemPressed(int index, BuildContext context) {
    debugPrint(
        '-> [MainPage] User is in the page: ${_pageController.page.truncate()}');
    if (_pageController.hasClients) {
      debugPrint('\n-> [MainPage] User has selected the page: $index');

      // We change to the page located at index
      _pageController
          .animateToPage(index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut)
          .then(
        (_) {
          // if that page is not
          if (index != _pageController.page.truncate()) {
            debugPrint(
                '-> [MainPage] User could have selected an invalid page.');
            showToast(
                context: context, message: '⚠ Página aún no disponible ⚠');
          }
        },
      );
    }
  }

  Future _setSpecialty(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SetSpeciality(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            body: PageView(
              controller: this._pageController,
              onPageChanged: this._onPageChanged,
              children: <Widget>[
                Home(),
                Profile(),
              ],
            ),
            floatingActionButton: floatingActionButton(
              context: context,
              icon: Icons.add,
              onPressed: () => _setSpecialty(context),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: this._page,
              showUnselectedLabels: false,
              selectedItemColor: Colors.white,
              backgroundColor: Color(0xff1266A4),
              iconSize: MediaQuery.of(context).size.width / 14,
              unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.50),

              // when the user taps on a item
              onTap: (int index) => _onBottomItemPressed(index, context),
              items: <BottomNavigationBarItem>[
                //Home()
                _newBarItem(
                  context: context,
                  title: 'INICIO',
                  icon: Icon(Icons.home),
                ),

                //Profile()
                _newBarItem(
                  context: context,
                  title: 'PERFIL',
                  icon: Icon(Icons.account_circle),
                ),

                //This page has not been defined yet.
                _newBarItem(context: context, icon: Icon(Icons.event)),

                //This page has not been defined yet.
                _newBarItem(context: context, icon: Icon(Icons.search))
              ],
            ),
          );
        },
      ),
    );
  }
}
