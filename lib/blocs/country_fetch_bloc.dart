import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coronatracker/models/country_stats.dart';
import 'package:coronatracker/services/web_api_handler.dart';

import './bloc.dart';

class CountryFetchBloc extends Bloc<CountryFetchEvent, CountryFetchState> {
  final CallWebService _callWebService;
  CountryFetchBloc(this._callWebService);
  @override
  CountryFetchState get initialState => CountryDataNotFetchedState();

  @override
  Stream<CountryFetchState> mapEventToState(
    CountryFetchEvent event,
  ) async* {
    if (event is DataFetchingEvent) {
      yield CountryDataFetchingState();
      List<CountryStats> listCoutryData =
          await _callWebService.getAlphabeticCountryList();
      if (listCoutryData == null) {
        yield CountryDataLoadErrorState();
      } else {
        yield CountryDataFetchedState(listAlphabateCountryData: listCoutryData);
      }
    }
  }
}
