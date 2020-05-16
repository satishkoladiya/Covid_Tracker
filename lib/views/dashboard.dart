import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/models/global_stats.dart';
import 'package:coronatracker/views/about_corona_page.dart';
import 'package:coronatracker/views/all_country_page.dart';
import 'package:coronatracker/views/country_detail_page.dart';
import 'package:coronatracker/widgets/case_widget.dart';
import 'package:coronatracker/widgets/country_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatelessWidget {
  Color getColor(int index) {
    Color color;
    switch (index) {
      case 0:
        color = Colors.grey.shade700;
        break;
      case 1:
        color = Colors.orange.shade800;
        break;
      case 2:
        color = Colors.blue.shade700;
        break;
      case 3:
        color = Colors.green.shade700;
        break;
      case 4:
        color = Colors.brown.shade700;
        break;
    }
    return color;
  }

  Color getTextColor(index) {
    Color color;
    switch (index) {
      case 0:
        color = Colors.grey;

        break;
      case 1:
        color = Colors.orange.shade400;

        break;
      case 2:
        color = Colors.blue.shade400;

        break;
      case 3:
        color = Colors.green.shade400;

        break;
      case 4:
        color = Colors.brown.shade400;

        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    final GlobalStats globalDataState = Provider.of<GlobalStats>(context);
    final List<CountryStats> listCountryStats =
        Provider.of<List<CountryStats>>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 220.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50)),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.deepOrange,
                    Colors.deepOrange.shade900,
                  ],
                )),
            child: SvgPicture.asset(
              'assets/images/doctor1.svg',
              fit: BoxFit.contain,
              alignment: Alignment.center,
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: false,

              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 0.0, left: 15.0, right: 15.0, bottom: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Covid-19 Tracker',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'See Details',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 15.0,
                    top: 0.0,
                  ),
                  child: Text(
                    (globalDataState == null)
                        ? ''
                        : 'Updated on : ${(DateFormat('dd MMM yyyy, hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(globalDataState.updated)))}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                ),
                (globalDataState == null)
                    ? Shimmer.fromColors(
                        period: Duration(milliseconds: 800),
                        baseColor: Colors.grey.withOpacity(0.5),
                        highlightColor: Colors.black.withOpacity(0.5),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CasesShimmer(),
                              CasesShimmer(),
                              CasesShimmer(),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 8.0,
                              spreadRadius: 8.0,
                              offset: Offset(0, 2),
                              color: Colors.black.withOpacity(0.01),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Cases(
                              icon: Icons.add,
                              strCaseCount: '${globalDataState.cases}',
                              strTitle: 'Infected',
                            ),
                            Cases(
                              icon: Icons.close,
                              strCaseCount: '${globalDataState.deaths}',
                              strTitle: 'Deaths',
                            ),
                            Cases(
                              icon: Icons.favorite,
                              strCaseCount: '${globalDataState.recovered}',
                              strTitle: 'Recovered',
                            ),
                          ],
                        ),
                      ),
                Container(
                  padding: EdgeInsets.only(
                      top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Most Affected Countries',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      FlatButton(
                          child: Text(
                            'View All',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AllCountryPage(
                                    countryStats: listCountryStats)));
                          }),
                    ],
                  ),
                ),
                (listCountryStats == null)
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Shimmer.fromColors(
                          period: Duration(milliseconds: 800),
                          baseColor: Colors.grey.withOpacity(0.5),
                          highlightColor: Colors.black.withOpacity(0.5),
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return CountryCardShimmer();
                            },
                            itemCount: 3,
                            shrinkWrap: true,
                            addAutomaticKeepAlives: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 5, right: 5),
                          ),
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CountryDetailsPage(
                                        countryStats:
                                            listCountryStats[index])));
                              },
                              child: CountryCard(
                                strFlagUrl:
                                    listCountryStats[index].countryInfo.flag,
                                strCountryName: listCountryStats[index].country,
                                infectedCount: listCountryStats[index].cases,
                                deathCount: listCountryStats[index].deaths,
                                darkColor: getColor(index),
                                lightColor: getColor(index),
                              ),
                            );
                          },
                          shrinkWrap: false,
                          addAutomaticKeepAlives: true,
                          itemCount: 5,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 0, bottom: 0),
                        ),
                      ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AllAboutCovid(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 200.0,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[
                          Container(
                            height: 170.0,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          Hero(
                            child: SvgPicture.asset(
                              'assets/images/nurse.svg',
                              fit: BoxFit.contain,
                            ),
                            tag: 'TOP',
                          ),
                          Positioned(
                            height: 130.0,
                            right: 0,
                            bottom: 0,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'All you need to know about Covid-19',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  'Read More',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
