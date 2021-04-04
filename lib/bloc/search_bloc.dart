import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testVerstka/bloc/result_of_search_bloc.dart' as search;
import 'package:testVerstka/main.dart';
import 'package:testVerstka/models/response_from_json.dart';
import 'package:testVerstka/screens/result_of_search_screen.dart';

abstract class SearchEvents {}

class InitialEvent extends SearchEvents {}

class ShowResultEvent extends SearchEvents {
  String q;
  ShowResultEvent({this.q});
}

abstract class SearchStates {}

class InitialState extends SearchStates {}

class ShowResultState extends SearchStates {
  String q;
  ShowResultState({this.q});
}

class SearchBloc {
  BehaviorSubject<SearchStates> _subject = BehaviorSubject<SearchStates>();
  BehaviorSubject<SearchStates> get subject => _subject;
  Connectivity connectivity = Connectivity();
  ResponseFromJson responseFromJson;

  void mapEventToState(SearchEvents event) async {
    switch (event.runtimeType) {
      case InitialEvent:
        _subject.sink.add(InitialState());
        break;
      case ShowResultEvent:
        ConnectivityResult connect = await connectivity.checkConnectivity();
        if (connect != ConnectivityResult.none) {
          search.resultOfSearchBloc.mapEventToState(
              search.InitialEvent(q: (event as ShowResultEvent).q));
          navigatorKey.currentState.pushNamed(ResultOfSearch.routeName);
        } else {
          _subject.sink.add(InitialState());
        }
        break;
    }
  }

  void dispose() {
    _subject?.close();
  }
}

final searchBloc = SearchBloc();
