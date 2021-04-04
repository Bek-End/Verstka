import 'package:testVerstka/models/repo_model.dart';

class ResponseFromJson {
  final RepositoryModel repoModel;
  final String error;

  ResponseFromJson({this.repoModel, this.error});

  ResponseFromJson.fromJson(var json)
      : repoModel = RepositoryModel.fromJson(json),
        error = "";

  ResponseFromJson.withError(String errorValue)
      : error = errorValue,
        repoModel = RepositoryModel();
}