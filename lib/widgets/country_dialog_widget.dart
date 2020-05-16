import 'package:coronatracker/blocs/country_fetch_bloc.dart';
import 'package:coronatracker/blocs/country_fetch_state.dart';
import 'package:coronatracker/provider/shared_pref_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CountryChangeDialog extends StatefulWidget {
  @override
  _CountryChangeDialogState createState() => _CountryChangeDialogState();
}

class _CountryChangeDialogState extends State<CountryChangeDialog> {
  List<String> listCountry;
  List<String> listCountryCodes;
  String _currentSelectedCountry, _currentSelectedCountryCode;
  var sharedPreferencesData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    sharedPreferencesData = Provider.of<SharedPrefrenceProvider>(context);
    _currentSelectedCountryCode =
        sharedPreferencesData.getSharedPrefrence().getString('COUNTRYCODE');
    return AlertDialog(
      title: Text(
        'Select your country',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
      ),
      elevation: 5.0,
      content: BlocBuilder<CountryFetchBloc, CountryFetchState>(
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
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: RaisedButton(
                    padding: EdgeInsets.all(14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Colors.deepOrange.shade400,
                    onPressed: () {
                      setState(() {
                        if (_currentSelectedCountry != null) {
                          int index =
                              listCountry.indexOf(_currentSelectedCountry);
                          _currentSelectedCountryCode = listCountryCodes[index];

                          sharedPreferencesData.addKeyToSharedPref(
                              'COUNTRYCODE', _currentSelectedCountryCode);

                          Navigator.of(context)
                              .pop(_currentSelectedCountryCode);
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
            ),
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
      }),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.deepOrange, fontSize: 17.0),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
