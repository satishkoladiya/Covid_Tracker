import 'package:equatable/equatable.dart';

abstract class CountryFetchEvent extends Equatable {
  const CountryFetchEvent();
  @override
  List<Object> get props => [];
}

class DataFetchingEvent extends CountryFetchEvent {
  const DataFetchingEvent();
}
