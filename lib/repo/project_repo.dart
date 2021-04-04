import 'package:dio/dio.dart';
import 'package:testVerstka/models/response_from_json.dart';

class UrlToJson {
  Dio _dio;
  final String mainUrl = "https://api.github.com";

  UrlToJson() {
    _dio = Dio(BaseOptions(baseUrl: mainUrl));
  }

  Future<ResponseFromJson> getRepositories(String q) async {
    final String endPoint = "/search/repositories";
    final Map<String, String> queryParameter = {"q": q};
    try {
      Response response = await _dio.get(endPoint, queryParameters: queryParameter);
      print(response.data);
      return ResponseFromJson.fromJson(response.data);
    } catch (error) {
      print("Error $error");
      return ResponseFromJson.withError("Error: getting data");
    }
  }
}

final responseOfJson = UrlToJson();
