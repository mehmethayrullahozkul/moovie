final class WordPair {
  final String original;
  final String translation;

  WordPair._({required this.original, required this.translation});

  factory WordPair.fromData({
    required String original,
    required String translation,
  }) {
    return WordPair._(
      original: original,
      translation: translation,
    );
  }

  factory WordPair.fromMap(Map<String, dynamic> map) {
    return WordPair._(
      original: map["original"],
      translation: map["translation"],
    );
  }
}
