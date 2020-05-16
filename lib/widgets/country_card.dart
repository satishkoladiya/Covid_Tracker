import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  final String strFlagUrl;
  final String strCountryName;
  final String infectedCount;
  final String deathCount;
  final Color darkColor;
  final Color lightColor;

  CountryCard(
      {this.strFlagUrl,
      this.strCountryName,
      this.infectedCount,
      this.deathCount,
      this.darkColor,
      this.lightColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            darkColor,
            lightColor,
          ],
        ),
      ),
      margin: EdgeInsets.all(15.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(
                  strFlagUrl,
                  height: 18.0,
                  width: 26.0,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  strCountryName,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Infected',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  infectedCount.toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'Deaths',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  deathCount.toString(),
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CountryCardShimmer extends StatelessWidget {
  CountryCardShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 220,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black.withOpacity(0.15),
      ),
      margin: EdgeInsets.all(15.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 26.0,
                  height: 18.0,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  width: 35,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: 18,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
