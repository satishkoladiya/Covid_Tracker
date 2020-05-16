import 'package:coronatracker/blocs/bloc.dart';
import 'package:coronatracker/provider/all_country_data_provider.dart';
import 'package:coronatracker/provider/shared_pref_provider.dart';
import 'package:coronatracker/services/web_api_handler.dart';
import 'package:coronatracker/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  bool isAddProxyProvider = false;
  Future<SharedPreferences> getSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    getSharedPrefs();
    CallWebService callWebService = CallWebService();
    return MultiProvider(
      providers: [
        FutureProvider(
            create: (context) => callWebService.getGlobalStats(),
            catchError: (context, error) {
              print(error.toString());
            }),
        FutureProvider(
            create: (context) => callWebService.getAllCountryStats(),
            catchError: (context, error) {
              print(error.toString());
            }),
        BlocProvider(
          create: (context) =>
              CountryFetchBloc(CallWebService())..add(DataFetchingEvent()),
        ),
        FutureProvider(
            create: (context) => callWebService.getIndiaStats(),
            catchError: (context, error) {
              print(error.toString());
            }),
        ChangeNotifierProvider(
          create: (context) => SharedPrefrenceProvider(sharedPreferences),
        ),
        ChangeNotifierProvider(
          create: (context) => AllCountryData(),
        ),

//        ProxyProvider<SharedPrefrenceProvider, Future<CountryStats>>(
//          update: (context, pref, countryStats) => (pref != null)
//              ? ((pref.getSharedPrefrence().containsKey('COUNTRYCODE') &&
//                      pref.getSharedPrefrence().getString('COUNTRYCODE') !=
//                          null)
//                  ? CallWebService(
//                          countryCode: pref
//                              .getSharedPrefrence()
//                              .getString('COUNTRYCODE'))
//                      .getCountryData()
//                  : null)
//              : null,
//        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Ubuntu',
          primarySwatch: Colors.deepOrange,
        ),
        home: Home(),
      ),
    );
  }
}
