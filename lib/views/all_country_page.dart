import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/views/country_detail_page.dart';
import 'package:flutter/material.dart';

class AllCountryPage extends StatefulWidget {
  List<CountryStats> countryStats;
  List<CountryStats> filteredStats = [];
  AllCountryPage({this.countryStats});

  @override
  _AllCountryPageState createState() => _AllCountryPageState();
}

class _AllCountryPageState extends State<AllCountryPage> {
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    widget.countryStats.forEach((element) {
      widget.filteredStats.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    String searchText = '';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Countries',
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: (textEditingController.text.isEmpty == false)
                      ? Icon(
                          Icons.close,
                          size: 20,
                        )
                      : Text(''),
                  onPressed: () {
                    setState(() {
                      textEditingController.text = '';
                      widget.filteredStats.clear();
                      widget.countryStats.forEach((element) {
                        widget.filteredStats.add(element);
                      });
                    });
                  },
                ),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(20.0),
                  ),
                ),
                labelText: 'Search Country',
                hintText: 'Search Country',
                focusColor: Colors.deepOrange,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value;
                  if (value.isEmpty) {
                    widget.filteredStats.clear();
                    widget.countryStats.forEach((element) {
                      widget.filteredStats.add(element);
                    });
                  } else {
                    if (widget.filteredStats.length != 0) {
                      widget.filteredStats.clear();
                    }
                    print('state count ${widget.countryStats.length}');
                    widget.countryStats.forEach((element) {
                      if (element.country
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        widget.filteredStats.add(element);
                      }
                    });
                    print('filter count ${widget.filteredStats.length}');
                  }
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  CountryStats stateData;

                  stateData = widget.filteredStats[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CountryDetailsPage(
                              countryStats: widget.filteredStats[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
                      padding: EdgeInsets.all(20),
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
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Image.network(
                                '${stateData.countryInfo.flag}',
                                height: 18.0,
                                width: 26.0,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                '${stateData.country}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${stateData.cases}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Infected',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepOrange.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${stateData.deaths}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Deaths',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepOrange.shade200,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${stateData.recovered}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'Recovered',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.deepOrange.shade200,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: (widget.filteredStats.length != 0)
                    ? widget.filteredStats.length
                    : 0,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(0)),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
