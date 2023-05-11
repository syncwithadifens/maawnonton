import 'package:flutter/material.dart';
import 'package:maawnonton/models/detail_model.dart';
import 'package:maawnonton/models/movies_model.dart';
import 'package:maawnonton/services/api_repository.dart';

class MoviesProvider extends ChangeNotifier {
  final _apiRepository = ApiRepository();
  bool isLoading = false;
  bool isSuccess = false;
  Movies? dataMoviesByNowPlaying;
  Movies? dataMoviesByPopular;
  DetailMovies? detailMovies;

  getMoviesByNowPlaying() async {
    isLoading = true;
    dataMoviesByNowPlaying = await _apiRepository.getNowPlaying();
    if (dataMoviesByNowPlaying != null) {
      isSuccess = true;
      isLoading = false;
      notifyListeners();
    } else {
      isSuccess = false;
      isLoading = false;
      notifyListeners();
    }
  }

  getMoviesByPopular() async {
    try {
      dataMoviesByPopular = await _apiRepository.getPopular();
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }

  getMoviesDetail(int id) async {
    isLoading = true;
    detailMovies = await _apiRepository.getDetail(id);
    if (detailMovies != null) {
      isLoading = false;
      isSuccess = true;
      notifyListeners();
    } else {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }
}
