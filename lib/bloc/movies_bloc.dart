import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:nowplaying/models/movie.dart';
import 'package:rxdart/rxdart.dart';

import 'movie_service.dart';

class MoviesBloc implements BlocBase {
  MovieService movieService;

  List<Movie> movies;

  final _moviesController = BehaviorSubject<List<Movie>>(seedValue: null);


  Stream<List<Movie>> get movieListControllerOut => _moviesController.stream;


  Function(List<Movie>) get movieListControllerUpdate =>
      _moviesController.sink.add;

  MoviesBloc() {
    movieService = MovieService();
    fetchListMovie();
  }

  fetchListMovie() async {
    try {
      if (null == movies) {
        movies = await movieService.fetchMovieList();
      } else {
        movies += await movieService.fetchMovieList();
      }
      movieListControllerUpdate(movies);
    } catch (e) {
      _moviesController.sink.addError(e);
    }
  }

  fetchSearchMoview(String keyword) async
  {
    try {
      if (null == movies) {
        movies = await movieService.fetchSearchMoview(keyword);
      } else {
        movies += await movieService.fetchSearchMoview(keyword);
      }
      movieListControllerUpdate(movies);
    } catch (e) {
      _moviesController.sink.addError(e);
    }
  }
  @override
  void dispose() {
    _moviesController.close();
  }
}
