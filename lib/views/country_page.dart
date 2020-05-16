import 'package:coronatracker/blocs/bloc.dart';
import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/models/india_stats.dart';
import 'package:coronatracker/provider/all_country_data_provider.dart';
import 'package:coronatracker/provider/shared_pref_provider.dart';
import 'package:coronatracker/services/web_api_handler.dart';
import 'package:coronatracker/views/state_page.dart';
import 'package:coronatracker/widgets/bulletin_widget.dart';
import 'package:coronatracker/widgets/color_bar_widget.dart';
import 'package:coronatracker/widgets/country_dialog_widget.dart';
import 'package:coronatracker/widgets/country_shimmer.dart';
import 'package:coronatracker/widgets/state_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  String _currentSelectedCountry, _currentSelectedCountryCode;
  List<String> listCountry = [];
  List<String> listCountryCodes = [];
  var sharedPreferencesData = null;
  var appState;

  @override
  void initState() {
    // TODO: implement initState
    print('init state');
    super.initState();
    getSharedPrefs();
  }

  void _showCountrySelectionDialog() async {
    var changed = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (context) {
        return CountryChangeDialog();
      },
    );

    if (changed != null) {
      setState(() {
        _currentSelectedCountryCode = changed;
        sharedPreferencesData.addKeyToSharedPref('COUNTRYCODE', changed);
        appState.fetchCountryStats(_currentSelectedCountryCode);
      });
    }
  }

  Future<SharedPreferences> getSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences;
  }

  SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    print('build');
    sharedPreferencesData = Provider.of<SharedPrefrenceProvider>(context);

//    final Future<CountryStats> countryStats =
//        Provider.of<Future<CountryStats>>(context);
    final IndiaStats indiaStats = Provider.of<IndiaStats>(context);
    _currentSelectedCountryCode =
        sharedPreferencesData.getSharedPrefrence().getString('COUNTRYCODE');

    appState = Provider.of<AllCountryData>(context);

    return Consumer<SharedPrefrenceProvider>(
      builder: (context, sharedPreferencesData, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Country',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
          ),
          body: (_currentSelectedCountryCode == null)
              ? BlocBuilder<CountryFetchBloc, CountryFetchState>(
                  builder: (context, state) {
                  if (state is CountryDataFetchingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is CountryDataFetchedState) {
                    listCountry = [];
                    listCountryCodes = [];
                    state.listAlphabateCountryData.forEach((element) {
                      listCountry.add(element.country);
                      listCountryCodes.add(element.countryInfo.iso2);
                    });
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        SvgPicture.asset(
                          'assets/images/location1.svg',
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.25,
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text(
                            'Select Your Country',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: InputDecorator(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              labelText: 'Select Country',
                              labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                            isEmpty: _currentSelectedCountry == null,
                            child: DropdownButton<String>(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              underline: SizedBox(
                                height: 0,
                              ),
                              isExpanded: true,
                              isDense: true,
                              items: listCountry.map((String e) {
                                return DropdownMenuItem<String>(
                                  child: Text(e),
                                  value: e,
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _currentSelectedCountry = value;
                                });
                              },
                              value: _currentSelectedCountry,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: RaisedButton(
                            padding: EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.deepOrange.shade400,
                            onPressed: () {
                              setState(() {
                                if (_currentSelectedCountry != null) {
                                  print(_currentSelectedCountryCode);
                                  int index = listCountry
                                      .indexOf(_currentSelectedCountry);
                                  _currentSelectedCountryCode =
                                      listCountryCodes[index];

                                  sharedPreferencesData.addKeyToSharedPref(
                                      'COUNTRYCODE',
                                      _currentSelectedCountryCode);

                                  print(_currentSelectedCountryCode);
                                  appState.fetchCountryStats(
                                      _currentSelectedCountryCode);
                                }
                              });
                            },
                            child: Text(
                              'Proceed',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(
                      child: Text(
                        'Data not loaded, please try again later',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    );
                  }
                })
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Consumer<AllCountryData>(
                      builder: (context, allCountryData, child) {
                        double activePer;
                        double recoveredPer;
                        double criticalPer;

                        CountryStats countryStats = appState.getCountryData();

                        double barWidth;

                        double activeCasesColorWidth;
                        double criticalCasesColorWidth;
                        double recoveredCasesColorWidth;
                        if ((countryStats != null)) {
                          activePer = double.parse(countryStats.active) /
                              int.parse(countryStats.cases) *
                              100;
                          recoveredPer = double.parse(countryStats.recovered) /
                              int.parse(countryStats.cases) *
                              100;
                          criticalPer = double.parse(countryStats.critical) /
                              int.parse(countryStats.cases) *
                              100;

                          barWidth = MediaQuery.of(context).size.width - 40.0;

                          activeCasesColorWidth =
                              (barWidth) * (activePer / 100);
                          recoveredCasesColorWidth =
                              (barWidth) * (recoveredPer / 100);
                          criticalCasesColorWidth =
                              (barWidth) * (criticalPer / 100);
                        }
                        return Expanded(
                          child: (appState.isFetching == true)
                              ? Shimmer.fromColors(
                                  period: Duration(milliseconds: 800),
                                  baseColor: Colors.grey.withOpacity(0.5),
                                  highlightColor: Colors.black.withOpacity(0.5),
                                  child: MyCountryShimmer(),
                                )
                              : ListView(
                                  padding: EdgeInsets.only(top: 25),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                          top: 0, left: 15, right: 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.place,
                                            size: 30,
                                            color: Colors.deepOrange,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Text(
                                              countryStats.country,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 22.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              setState(() {
                                                _showCountrySelectionDialog();
                                              });
                                            },
                                            child: Text(
                                              'Change Country',
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 17.0,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 20,
                                          bottom: 15),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange[50],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: ListTile(
                                        leading: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Icon(
                                              Icons.public,
                                              size: 30,
                                              color: Colors.deepOrange,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              'Total Cases',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                        trailing: Text(
                                          '${countryStats.cases}',
                                          textAlign: TextAlign.end,
                                          style: TextStyle(
                                            fontSize: 17.0,
                                            color: Colors.deepOrange,
                                          ),
                                        ),
                                      ),
                                    ),
                                    BulletinWidget(
                                      title: 'Active Cases',
                                      caseCount: int.parse(countryStats.active),
                                      dotColor: Colors.deepOrange,
                                    ),
                                    ColorBar(
                                      colorBarWidth: activeCasesColorWidth,
                                      color: Colors.deepOrange,
                                    ),
                                    BulletinWidget(
                                      title: 'Recovered Cases',
                                      caseCount:
                                          int.parse(countryStats.recovered),
                                      dotColor: Colors.pink[500],
                                    ),
                                    ColorBar(
                                      colorBarWidth: recoveredCasesColorWidth,
                                      color: Colors.pink[500],
                                    ),
                                    BulletinWidget(
                                      title: 'Critical Cases',
                                      caseCount:
                                          int.parse(countryStats.critical),
                                      dotColor: Colors.red,
                                    ),
                                    ColorBar(
                                      colorBarWidth: criticalCasesColorWidth,
                                      color: Colors.red,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10.0),
                                      margin: EdgeInsets.only(
                                          right: 20,
                                          left: 20,
                                          top: 40,
                                          bottom: 30),
                                      decoration: BoxDecoration(
                                        color: Colors.red[50],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Container(
                                                width: 30.0,
                                                height: 30.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red[100],
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.deepOrange,
                                                  size: 15,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Death\'s',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'Today',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${countryStats.todayDeaths}',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'Total',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${countryStats.deaths}',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 20.0),
                                      margin: EdgeInsets.only(
                                          top: 0,
                                          bottom: 10,
                                          left: 20,
                                          right: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.pink[50],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Mortality Rate',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Text(
                                            '${(100 * double.parse(countryStats.deaths) / int.parse(countryStats.cases)).toStringAsFixed(1)} %',
                                            style: TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      margin: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.orange[50],
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Per One Million',
                                            style: TextStyle(
                                              fontSize: 18.0,
                                            ),
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'Cases',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${countryStats.casesPerOneMillion}',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: <Widget>[
                                              Text(
                                                'Death\'s',
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${countryStats.deathsPerOneMillion}',
                                                style: TextStyle(
                                                  fontSize: 17.0,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    (_currentSelectedCountryCode == 'IN' &&
                                            indiaStats != null)
                                        ? Column(
                                            children: <Widget>[
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 10,
                                                    bottom: 10,
                                                    left: 20,
                                                    right: 20),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      'Most Affected States',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    StatePage(
                                                                        indiaStats:
                                                                            indiaStats.statewise)));
                                                      },
                                                      child: Text(
                                                        'View All',
                                                        textAlign:
                                                            TextAlign.right,
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color:
                                                              Colors.deepOrange,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 250,
                                                child: ListView.builder(
                                                  itemBuilder:
                                                      (context, index) {
                                                    Statewise stateData;
                                                    if (indiaStats
                                                            .statewise[0].state
                                                            .toUpperCase() ==
                                                        'TOTAL') {
                                                      stateData = indiaStats
                                                          .statewise[index + 1];
                                                    } else {
                                                      stateData = indiaStats
                                                          .statewise[index];
                                                    }
                                                    return StateCard(
                                                      stateName:
                                                          stateData.state,
                                                      infectedCount:
                                                          stateData.confirmed,
                                                      deathCount:
                                                          stateData.deaths,
                                                      darkColor:
                                                          Colors.grey.shade50,
                                                      lightColor:
                                                          Colors.green.shade50,
                                                    );
                                                  },
                                                  shrinkWrap: false,
                                                  addAutomaticKeepAlives: true,
                                                  itemCount: 5,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  padding: EdgeInsets.only(
                                                      left: 5,
                                                      right: 5,
                                                      top: 0,
                                                      bottom: 0),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                            ],
                                          )
                                        : SizedBox(
                                            height: 30,
                                          )
                                  ],
                                ),
                        );
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget getCountryWidget(
      /*Future<CountryStats> countryStats, IndiaStats indiaStats*/) {
    //final Future<CountryStats> countryStats =
    // Provider.of<Future<CountryStats>>(context);
    final IndiaStats indiaStats = Provider.of<IndiaStats>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        FutureProvider<CountryStats>(
          create: (context) =>
              CallWebService(countryCode: _currentSelectedCountryCode)
                  .getCountryData(),
          child: Consumer<CountryStats>(
            builder: (context, countryStats, child) {
              double activePer;
              double recoveredPer;
              double criticalPer;

              double barWidth;

              double activeCasesColorWidth;
              double criticalCasesColorWidth;
              double recoveredCasesColorWidth;
              if ((countryStats != null)) {
                activePer = double.parse(countryStats.active) /
                    int.parse(countryStats.cases) *
                    100;
                recoveredPer = double.parse(countryStats.recovered) /
                    int.parse(countryStats.cases) *
                    100;
                criticalPer = double.parse(countryStats.critical) /
                    int.parse(countryStats.cases) *
                    100;
                print('country load $_currentSelectedCountryCode');
                barWidth = MediaQuery.of(context).size.width - 40.0;

                activeCasesColorWidth = (barWidth) * (activePer / 100);
                recoveredCasesColorWidth = (barWidth) * (recoveredPer / 100);
                criticalCasesColorWidth = (barWidth) * (criticalPer / 100);
              }
              return Expanded(
                child: (countryStats == null)
                    ? Shimmer.fromColors(
                        period: Duration(milliseconds: 800),
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.black.withOpacity(0.5),
                        child: MyCountryShimmer(),
                      )
                    : ListView(
                        padding: EdgeInsets.only(top: 25),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 0),
                            child: ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.place,
                                    size: 30,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    countryStats.country,
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Image.network(
                                    '${countryStats.countryInfo.flag}',
                                    height: 21,
                                  )
                                ],
                              ),
                              trailing: FlatButton(
                                onPressed: () {
                                  setState(() {
                                    _showCountrySelectionDialog();
                                  });
                                },
                                child: Text(
                                  'Change Country',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.deepOrange,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 20, right: 20, top: 20, bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: ListTile(
                              leading: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Icon(
                                    Icons.public,
                                    size: 30,
                                    color: Colors.deepOrange,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Total Cases',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Text(
                                '${countryStats.cases}',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ),
                          ),
                          BulletinWidget(
                            title: 'Active Cases',
                            caseCount: int.parse(countryStats.active),
                            dotColor: Colors.deepOrange,
                          ),
                          ColorBar(
                            colorBarWidth: activeCasesColorWidth,
                            color: Colors.deepOrange,
                          ),
                          BulletinWidget(
                            title: 'Recovered Cases',
                            caseCount: int.parse(countryStats.recovered),
                            dotColor: Colors.pink[500],
                          ),
                          ColorBar(
                            colorBarWidth: recoveredCasesColorWidth,
                            color: Colors.pink[500],
                          ),
                          BulletinWidget(
                            title: 'Critical Cases',
                            caseCount: int.parse(countryStats.critical),
                            dotColor: Colors.red,
                          ),
                          ColorBar(
                            colorBarWidth: criticalCasesColorWidth,
                            color: Colors.red,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            margin: EdgeInsets.only(
                                right: 20, left: 20, top: 40, bottom: 30),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red[100],
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.deepOrange,
                                        size: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Death\'s',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Today',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${countryStats.todayDeaths}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Total',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${countryStats.deaths}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20.0),
                            margin: EdgeInsets.only(
                                top: 0, bottom: 10, left: 20, right: 20),
                            decoration: BoxDecoration(
                              color: Colors.pink[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Mortality Rate',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                Text(
                                  '${(100 * double.parse(countryStats.deaths) / int.parse(countryStats.cases)).toStringAsFixed(1)} %',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 15.0),
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.orange[50],
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Per One Million',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Cases',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${countryStats.casesPerOneMillion}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Death\'s',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${countryStats.deathsPerOneMillion}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          (_currentSelectedCountryCode == 'IN' &&
                                  indiaStats != null)
                              ? Column(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 20,
                                          right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            'Most Affected States',
                                            style: TextStyle(
                                              fontSize: 20,
                                            ),
                                          ),
                                          FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          StatePage(
                                                              indiaStats: indiaStats
                                                                  .statewise)));
                                            },
                                            child: Text(
                                              'View All',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.deepOrange,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 250,
                                      child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          Statewise stateData;
                                          if (indiaStats.statewise[0].state
                                                  .toUpperCase() ==
                                              'TOTAL') {
                                            stateData =
                                                indiaStats.statewise[index + 1];
                                          } else {
                                            stateData =
                                                indiaStats.statewise[index];
                                          }
                                          return StateCard(
                                            stateName: stateData.state,
                                            infectedCount: stateData.confirmed,
                                            deathCount: stateData.deaths,
                                            darkColor: Colors.grey.shade50,
                                            lightColor: Colors.green.shade50,
                                          );
                                        },
                                        shrinkWrap: false,
                                        addAutomaticKeepAlives: true,
                                        itemCount: 5,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        padding: EdgeInsets.only(
                                            left: 5,
                                            right: 5,
                                            top: 0,
                                            bottom: 0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ],
                                )
                              : SizedBox(
                                  height: 30,
                                )
                        ],
                      ),
              );
            },
          ),
        ),
      ],
    );
  }
}
