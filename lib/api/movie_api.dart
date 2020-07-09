
import 'package:nowplaying/models/movie.dart';
import 'package:nowplaying/models/now_playing.dart';
import 'package:nowplaying/utils/common_methods.dart';
import 'package:http/http.dart' show Client, Response;
class MovieApiProvider {
  Client client = Client();
  final _apiKey = CommonMethods.apiKey;
  final _baseUrl = "https://api.themoviedb.org/3/";
  final _urlnowplaying = "movie/now_playing";
  final _searchmovie = "search/movie";
  final language = "language=en-US";
  int _page = 1;

  Future<List<Movie>> fetchMovieList() async {
    Response response;

      response = await client
          .get("$_baseUrl$_urlnowplaying?api_key=$_apiKey&$language&page=$_page");

    if (response.statusCode == 200) {
      _page++;
      print(response.body);
      return nowPlayingFromJson(response.body).movies;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<List<Movie>> fetchSearchMovie(String keyword) async {
    Response response;

    response = await client
        .get("$_baseUrl$_searchmovie?api_key=$_apiKey&$language&query=$keyword&page=$_page");

    if (response.statusCode == 200) {
      _page++;
      print(response.body);
      return nowPlayingFromJson(response.body).movies;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
 
}