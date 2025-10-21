import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/get_categories.dart';
import 'home_state.dart';

/// ViewModel for home feature following MVVM pattern
class HomeViewModel extends StateNotifier<HomeState> {
  final GetCategories getCategories;

  HomeViewModel({required this.getCategories}) : super(const HomeState()) {
    loadCategories();
  }

  /// Load all categories
  Future<void> loadCategories() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final categories = await getCategories();
      state = state.copyWith(
        categories: categories,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'حدث خطأ أثناء تحميل القائمة',
      );
    }
  }
}

