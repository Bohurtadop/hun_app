import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hun_app/Screens/Home.dart';
import 'package:hun_app/Screens/Profile.dart';
import 'package:hun_app/Screens/SetSpeciality.dart';

class MainPage extends StatefulWidget {
  final String uid;
  final int initialPage;
  MainPage({this.uid, this.initialPage = 0});

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

  _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Colors.orange,
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => SetSpeciality(widget.uid),
        ),
      ),
      child: Icon(
        Icons.add,
        size: MediaQuery.of(context).size.width / 12,
      ),
    );
  }

  void _onPageChanged(int page) {
    setState(() {
      return _page = page;
    });
    debugPrint('[MainPage] Current page: $page');
  }

  void _onBottomNavItemPressed(int index) {
    setState(() => _page = index);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
      debugPrint('\n[MainPage] User has selected the page: $index\n');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: this._pageController,
        onPageChanged: this._onPageChanged,
        children: <Widget>[
          Home(uid: widget.uid),
          Profile(uid: widget.uid),
        ],
      ),
      floatingActionButton: _floatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: this._page,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xff1266A4),
        iconSize: MediaQuery.of(context).size.width / 14,
        unselectedItemColor: Color.fromRGBO(255, 255, 255, 0.50),
        onTap: this._onBottomNavItemPressed,
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
  }
}
