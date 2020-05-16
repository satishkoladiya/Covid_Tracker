import 'package:connectivity/connectivity.dart';
import 'package:coronatracker/models/india_stats.dart';
import 'package:coronatracker/provider/all_country_data_provider.dart';
import 'package:coronatracker/provider/shared_pref_provider.dart';
import 'package:coronatracker/services/connectivity_check.dart';
import 'package:coronatracker/services/web_api_handler.dart';
import 'package:coronatracker/views/about_page.dart';
import 'package:coronatracker/views/country_page.dart';
import 'package:coronatracker/views/dashboard.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String strTitle = 'Covid-19 Stats';
  int selectedTabIndex = 0;
  bool isConnectedToInternet = true;
  var appState;
  GlobalKey bottomNavigationKey = GlobalKey();
  bool isFetchedCountryData = false;

  List<BottomNavigationBarItem> listBottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.whatshot),
      title: Text('Dashboard'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      title: Text('My Country'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text('About'),
    ),
  ];

  List<TabData> listFancyBottomNavigationBarItems = [
    TabData(
      iconData: Icons.whatshot,
      title: 'Dashboard',
    ),
    TabData(
      iconData: Icons.map,
      title: 'My Country',
    ),
    TabData(
      iconData: Icons.person,
      title: 'About',
    ),
  ];

  List<String> strTabNames = [
    'Covid-19 Stats',
    'My Country',
    'About',
  ];

  List<Widget> tabPages = [
    Dashboard(),
    CountryPage(),
    About(),
  ];

  FancyBottomNavigation getFancyBottomNavigationBar() {
    return FancyBottomNavigation(
      tabs: listFancyBottomNavigationBarItems,
      onTabChangedListener: _onItemTapped,
      initialSelection: selectedTabIndex,
      key: bottomNavigationKey,
    );
  }

  BottomNavigationBar getBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: listBottomNavigationBarItems,
      currentIndex: selectedTabIndex,
      onTap: _onItemTapped,
    );
  }

  Map _source = {ConnectivityResult.none: false};
  ConnectionCheck _connectivity = ConnectionCheck.instance;

  void _onItemTapped(int index) {
    setState(() {
      selectedTabIndex = index;
      strTitle = strTabNames[selectedTabIndex];
      if (isFetchedCountryData == false) {
        appState = Provider.of<AllCountryData>(context, listen: false);
        final sharedPref =
            Provider.of<SharedPrefrenceProvider>(context, listen: false);
        if (sharedPref.getSharedPrefrence().containsKey('COUNTRYCODE')) {
          appState.fetchCountryStats(
              sharedPref.getSharedPrefrence().getString('COUNTRYCODE'));
          isFetchedCountryData = true;
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      _connectivity.myStream.listen((source) {
        setState(() {
          _source = source;
          print('check');
          switch (_source.keys.toList()[0]) {
            case ConnectivityResult.none:
              isConnectedToInternet = false;
              print('no internet');
              break;
            case ConnectivityResult.mobile:
              print('connected wifi');
              isConnectedToInternet = true;
              break;
            case ConnectivityResult.wifi:
              print('connected wifi');
              isConnectedToInternet = true;
              break;
          }
        });
      });
    });

    if (isConnectedToInternet) {}
  }

  @override
  void dispose() {
    _connectivity.disposeStream();
    super.dispose();
  }

  void getGlobalStats() async {
    IndiaStats acsl = await CallWebService().getIndiaStats();
    print('data ${acsl.statewise.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text(strTitle),
//      ),
      body: Center(
        child: isConnectedToInternet
            ? tabPages[selectedTabIndex]
            : Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Lottie.asset(
                        'assets/data.json',
                      ),
                    ),
                  )
                ],
              ),
      ),
      bottomNavigationBar:
          isConnectedToInternet ? getFancyBottomNavigationBar() : null,
    );
  }
}
