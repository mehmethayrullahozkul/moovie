import 'package:workarea_v8/models/word_pair/word_pair_model.dart';
import 'package:workarea_v8/repository/data_repository.dart';

class DataService {
  late final DataRepository dataRepository;
  static late final DataService _instance;
  List<WordPair> _wordPairs = [];
  int _wordPairCount = 0;

  List<WordPair> get wordPairs => _wordPairs;
  int get wordPairCount => _wordPairCount;

  static Future<DataService> init() async {
    DataService dataService = DataService._internal();
    await dataService.initialize();
    _instance = dataService;
    return _instance;
  }

  Future<void> initialize() async {
    dataRepository = await DataRepository.init();
  }

  factory DataService() {
    return _instance;
  }

  DataService._internal() {
    _wordPairCount = 0;
    _wordPairs = [];
  }

  Future<List<WordPair>> getRandomWordPairs({required int count}) async {
    final List<Map<String, String>> wordPairsMap =
        await dataRepository.getRandomWordPairs(wordCount: count);

    // if wordPairsMap is empty, return an empty list
    if (wordPairsMap.isEmpty) {
      return [];
    }

    List<WordPair> buffer = [];

    for (Map<String, String> wordPairMap in wordPairsMap) {
      ;
      buffer.add(WordPair.fromMap(wordPairMap));
    }

    _wordPairs = buffer;
    _wordPairCount = buffer.length;
    return _wordPairs;
  }

  void clearWordPairs() {
    _wordPairs = [];
    _wordPairCount = 0;
  }
}
// Path: lib/models/user/user_credentials_realm.dart