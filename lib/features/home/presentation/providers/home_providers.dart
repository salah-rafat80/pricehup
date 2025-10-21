import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/get_categories.dart';
import '../viewmodels/home_state.dart';
import '../viewmodels/home_viewmodel.dart';

/// Provider for GetCategories use case
final getCategoriesProvider = Provider<GetCategories>((ref) => sl());

/// Provider for HomeViewModel
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(
    getCategories: ref.read(getCategoriesProvider),
  ),
);

