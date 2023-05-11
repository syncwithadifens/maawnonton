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
    try {
      isLoading = true;
      dataMoviesByNowPlaying = await _apiRepository.getNowPlaying();
      isSuccess = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }

  getMoviesByPopular() async {
    try {
      isLoading = true;
      dataMoviesByPopular = await _apiRepository.getPopular();
      isSuccess = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }

  getMoviesDetail(int id) async {
    try {
      isLoading = true;
      detailMovies = await _apiRepository.getDetail(id);
      isSuccess = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      isSuccess = false;
      notifyListeners();
    }
  }
}
