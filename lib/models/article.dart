class Article {
  final String url;
  final String title;
  final String byLine;
  final String description;
  final String section;
  final List multiMedia;

  const Article(
      {required this.url,
      required this.title,
      required this.byLine,
      required this.description,
      required this.section,
      required this.multiMedia});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      url: json['url'] as String,
      title: json['title'] as String,
      byLine: json['byline'] as String,
      description: json['abstract'] as String,
      section: json['section'] as String,
      multiMedia: json['multimedia'] as List,
    );
  }
}
