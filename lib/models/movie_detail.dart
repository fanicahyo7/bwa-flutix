part of 'models.dart';

class MovieDetail extends Movie {
  final List<String> genre;
  final String language;

  MovieDetail(Movie movie, {this.genre, this.language})
      : super(
            id: movie.id,
            title: movie.title,
            voteAverage: movie.voteAverage,
            overview: movie.overview,
            backdropPath: movie.backdropPath,
            posterPath: movie.posterPath);

  String get genreAndLanguage {
    String s = "";
    for (var genres in genre) {
      s += genres + (genres != genre.last ? ', ' : '');
    }
    return "$s - $language";
  }

  @override
  List<Object> get props => super.props + [genre, language];
}
