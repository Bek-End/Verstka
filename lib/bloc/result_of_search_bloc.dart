import 'package:connectivity/connectivity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:testVerstka/models/repo_model.dart';
import 'package:testVerstka/models/response_from_json.dart';
import 'package:testVerstka/repo/project_repo.dart';

abstract class ResultOfSearchEvents {}

class InitialEvent extends ResultOfSearchEvents {
  final String q;
  InitialEvent({this.q});
}

abstract class ResultOfSearchStates {}

class InitialState extends ResultOfSearchStates {
  final String q;
  final RepositoryModel repoModel;
  InitialState(this.q, this.repoModel);
}

class ResultOfSearchBloc {
  BehaviorSubject<ResultOfSearchStates> _subject =
      BehaviorSubject<ResultOfSearchStates>();
  BehaviorSubject<ResultOfSearchStates> get subject => _subject;
  Connectivity connectivity = Connectivity();
  ResponseFromJson responseFromJson;

  void mapEventToState(ResultOfSearchEvents event) async {
    switch (event.runtimeType) {
      case InitialEvent:
        responseFromJson =
            await responseOfJson.getRepositories((event as InitialEvent).q);
        _subject.sink.add(InitialState(
            (event as InitialEvent).q, responseFromJson.repoModel));
        break;
    }
  }
}

final resultOfSearchBloc = ResultOfSearchBloc();
