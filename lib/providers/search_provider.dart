import 'package:flutter/material.dart';
import 'package:maawnonton/models/search_model.dart';
import 'package:maawnonton/services/api_repository.dart';

class SearchProvider extends ChangeNotifier {
  final _apiRepository = ApiRepository();
  bool isLoading = false;
  bool isSuccess = false;
  String query = '';
  Search? dataSearch;
  Future<void> searchMovie() async {
    try {
      isLoading = true;
      dataSearch = await _apiRepository.searchMovie(query);
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
