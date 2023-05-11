import 'package:flutter/material.dart';
import 'package:maawnonton/models/movies_model.dart';
import 'package:maawnonton/services/api_repository.dart';

class MoviesProvider extends ChangeNotifier {
  final _apiRepository = ApiRepository();
  bool isLoading = false;
  Movies? dataMoviesByNowPlaying;
  Movies? dataMoviesByPopular;
  Future<void> getMoviesByNowPlaying() async {
    try {
      isLoading = true;
      final response = await _apiRepository.getNowPlaying();
      if (response.results.isNotEmpty) {
        dataMoviesByNowPlaying = response;
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> getMoviesByPopular() async {
    try {
      isLoading = true;
      final response = await _apiRepository.getPopular();
      if (response.results.isNotEmpty) {
        dataMoviesByPopular = response;
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
    }
  }
}
