import 'package:nowplaying/models/movie.dart';
import 'package:nowplaying/repo/movie_repository.dart';

class MovieService {
  Future<List<Movie>> fetchMovieList() async {
    try {
      MovieRepository _movieRepository = new MovieRepository();
      
      var movies = await _movieRepository.fetchAllMovies();
      
      return movies;
    } catch (e) {
      throw Exception("Failed to get movies list: ${e.toString().substring(10)}");
    }
  }

  Future<List<Movie>> fetchSearchMoview(String keyword) async {
    try {
      MovieRepository _movieRepository = new MovieRepository();

      var movies = await _movieRepository.fetchSearchMovies(keyword);

      return movies;
    } catch (e) {
      throw Exception("Failed to get movies list: ${e.toString().substring(10)}");
    }
  }
}
