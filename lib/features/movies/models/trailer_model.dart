class Trailer {
  final String name;
  final String videoLink;
  final String imageUrl;

  Trailer({
    required this.name,
    required this.videoLink,
    required this.imageUrl,
  });

  factory Trailer.fromJson(Map<String, dynamic> json) {
    final videoKey = json['key'] as String;
    return Trailer(
      name: json['name'] as String,
      videoLink: "https://www.youtube.com/watch?v=$videoKey",
      imageUrl: 'https://img.youtube.com/vi/$videoKey/hqdefault.jpg',
    );
  }
}
