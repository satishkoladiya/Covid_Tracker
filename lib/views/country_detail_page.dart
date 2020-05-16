import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/widgets/bulletin_widget.dart';
import 'package:coronatracker/widgets/color_bar_widget.dart';
import 'package:flutter/material.dart';

class CountryDetailsPage extends StatelessWidget {
  final CountryStats countryStats;
  CountryDetailsPage({this.countryStats});
  @override
  Widget build(BuildContext context) {
    double activePer =
        double.parse(countryStats.active) / int.parse(countryStats.cases) * 100;
    double recoveredPer = double.parse(countryStats.recovered) /
        int.parse(countryStats.cases) *
        100;
    double criticalPer = double.parse(countryStats.critical) /
        int.parse(countryStats.cases) *
        100;

    double barWidth = MediaQuery.of(context).size.width - 40.0;

    double activeCasesColorWidth = (barWidth) * (activePer / 100);
    double recoveredCasesColorWidth = (barWidth) * (recoveredPer / 100);
    double criticalCasesColorWidth = (barWidth) * (criticalPer / 100);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${countryStats.country}',
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 20),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 15),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  margin:
                      EdgeInsets.only(right: 20, left: 20, top: 40, bottom: 30),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                  margin:
                      EdgeInsets.only(top: 0, bottom: 10, left: 20, right: 20),
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
                        '${(100 * int.parse(countryStats.deaths) / int.parse(countryStats.cases)).toStringAsFixed(1)} %',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
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
                SizedBox(
                  height: 30,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
