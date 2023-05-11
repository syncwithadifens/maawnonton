import 'package:http/http.dart' as http;
import 'package:maawnonton/models/detail_model.dart';
import 'package:maawnonton/models/movies_model.dart';
import 'package:maawnonton/models/search_model.dart';

class ApiRepository {
  final _baseUrl = 'https://api.themoviedb.org/3';
  final _apiKey = '2ef28ffaf00e86bef9ebbc43a16751aa';
  final int _page = 1;

  Future<Movies> getNowPlaying() async {
    var response = await http
        .get(Uri.parse('$_baseUrl/movie/now_playing?api_key=$_apiKey&$_page'));

    if (response.statusCode == 200) {
      return moviesFromJson(response.body);
    } else {
      throw Exception('Fails to get data');
    }
  }

  Future<Movies> getPopular() async {
    var response = await http
        .get(Uri.parse('$_baseUrl/movie/popular?api_key=$_apiKey&$_page'));

    if (response.statusCode == 200) {
      return moviesFromJson(response.body);
    } else {
      throw Exception('Fails to get data');
    }
  }

  Future<DetailMovies> getDetail(int movieId) async {
    var response =
        await http.get(Uri.parse('$_baseUrl/movie/$movieId?api_key=$_apiKey'));

    if (response.statusCode == 200) {
      return detailMoviesFromJson(response.body);
    } else {
      throw Exception('Fails to get data');
    }
  }

  Future<Search> searchMovie(String query) async {
    var response = await http
        .get(Uri.parse('$_baseUrl/search/movie?query=$query&api_key=$_apiKey'));

    if (response.statusCode == 200) {
      return searchFromJson(response.body);
    } else {
      throw Exception('Fails to get data');
    }
  }
}
