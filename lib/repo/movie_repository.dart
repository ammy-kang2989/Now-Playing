import 'package:nowplaying/api/movie_api.dart';
import 'package:nowplaying/models/movie.dart';

class MovieRepository {
  final moviesApiProvider = MovieApiProvider();

  Future<List<Movie>> fetchAllMovies() => moviesApiProvider.fetchMovieList();
  
  Future<List<Movie>> fetchSearchMovies(String kewywod) => moviesApiProvider.fetchSearchMovie(kewywod);

}