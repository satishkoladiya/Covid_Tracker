import 'package:coronatracker/models/country_stats.dart';
import 'package:equatable/equatable.dart';

abstract class CountryFetchState extends Equatable {
  const CountryFetchState();
  @override
  List<Object> get props => [];
}

class CountryDataNotFetchedState extends CountryFetchState {
  const CountryDataNotFetchedState();
}

class CountryDataFetchingState extends CountryFetchState {
  const CountryDataFetchingState();
}

class CountryDataFetchedState extends CountryFetchState {
  final List<CountryStats> listAlphabateCountryData;
  const CountryDataFetchedState({this.listAlphabateCountryData});

  @override
  List<Object> get props => [listAlphabateCountryData];
}

class CountryDataLoadErrorState extends CountryFetchState {
  const CountryDataLoadErrorState();
}
