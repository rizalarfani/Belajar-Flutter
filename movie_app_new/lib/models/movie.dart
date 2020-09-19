import 'package:json_annotation/json_annotation.dart';


part 'movie.g.dart';

@JsonSerializable()
class Movie {
      Movie();

  double popularity;
  @JsonKey(name: 'vote_count') int voteCount;
  bool video;
  @JsonKey(name: 'poster_path') String posterPath;
  int id;
  bool adult;
  @JsonKey(name: 'backdrop_path') String backdropPath;
  @JsonKey(name: 'original_language') String originalLanguage;
  @JsonKey(name: 'original_title') String originalTitle;
  @JsonKey(name: 'genre_ids') List<dynamic> genreIds;
  String title;
  @JsonKey(name: 'vote_average') double voteAverage;
  String overview;
  @JsonKey(name: 'release_date') String releaseDate;

  factory Movie.fromJson(Map<String,dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
