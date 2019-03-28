class MovieModel {
  final String link;
  final String movieCode;
  final String thumbnail;
  final String title;
  final String pubDate;
  final String director;
  final String actor;
  final String userRating;

  String description;
  String realPhoto;
  List<String> subImages;

  MovieModel._({
    this.link,
    this.movieCode,
    this.thumbnail,
    this.title,
    this.director,
    this.actor,
    this.userRating,
    this.pubDate,

    this.description,
    this.realPhoto,
    this.subImages
  });

  factory MovieModel.fromJson(Map<String,dynamic> json) {
    String movieTitle = (json['title'] as String)
      .replaceAll('<b>', '')
      .replaceAll('</b>', '');
    String movieDirector = (json['director'] as String)
      .split('|')[0];
    String movieActor = (json['actor'] as String)
      .split('|')[0];
    String movieCode = (json['link'] as String)
      .split('=')[1];
    return MovieModel._(
      link: json['link'] as String,
      movieCode: movieCode,
      thumbnail: json['image'] as String,
      title: movieTitle,
      director: movieDirector,
      actor: movieActor,
      userRating: json['userRating'] as String,
      pubDate: json['pubDate'] as String
    );
  }

  @override
  String toString() {
    String result
    = 'link: $link\n'
      'movieCode: $movieCode\n'
      'thumbnail: $thumbnail\n'
      'title: $title\n'
      'director: $director\n'
      'actor: $actor\n'
      'userRating: $userRating\n'
      'pubDate: $pubDate\n'
      'description: $description\n'
      'realPhoto: $realPhoto\n';
    return result;
  }
}