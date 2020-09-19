class MovieModel {
  final String posterPath;
  final String originalTitle;

  MovieModel({this.posterPath, this.originalTitle});
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        posterPath: json['poster_path'], originalTitle: json['original_title']);
  }
}
