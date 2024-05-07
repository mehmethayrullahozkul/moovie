import 'package:dio/dio.dart';
import 'package:workarea_v8/repository/remote_storage.dart/remote_storage.dart';

class DataRepository {
  static const String getRandomWordPairUrl = "/getrandomwordpairs";

  late final RemoteStorage _remoteStorage;

  static Future<DataRepository> init() async {
    DataRepository dataRepository = DataRepository();
    await dataRepository.initialize();
    return dataRepository;
  }

  Future<void> initialize() async {
    _remoteStorage = RemoteStorage();
  }

  Future<List<Map<String, String>>> getRandomWordPairs(
      {required int wordCount}) async {
    late final Response response;

    try {
      response = await _remoteStorage
          .get(API.baseUrl + getRandomWordPairUrl, data: {"count": wordCount});
      if (response.statusCode == 200) {
        List<dynamic> wordPairMaps = response.data["wordPairs"];
        List<Map<String, String>> wordPairs = [];

        for (var wordPair in wordPairMaps) {
          wordPairs.add({
            "original": wordPair["original"],
            "translation": wordPair["translation"],
          });
        }
        return wordPairs;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print("Error: DioException");
      print(e);
      return [];
    }
  }
}
