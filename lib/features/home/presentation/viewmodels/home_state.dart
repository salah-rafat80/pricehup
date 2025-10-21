import '../../domain/entities/category.dart';

/// State for home feature
class HomeState {
  final List<Category> categories;
  final bool isLoading;
  final String? error;

  const HomeState({
    this.categories = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<Category>? categories,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

