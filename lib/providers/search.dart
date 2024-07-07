import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final searchHistoryProvider =
    StateNotifierProvider<SearchNotifier, List<String>>((ref) {
  return SearchNotifier();
});

class SearchNotifier extends StateNotifier<List<String>> {
  SearchNotifier() : super([]) {
    _loadSearchHistory();
  }

  static const String _key = 'search_history';

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_key) ?? [];
    state = history;
  }

  Future<void> addSearch(String city) async {
    if (!state.contains(city)) {
      state = [city, ...state];
      if (state.length > 5) {
        state = state.sublist(0, 5);
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(_key, state);
    }
  }
}
