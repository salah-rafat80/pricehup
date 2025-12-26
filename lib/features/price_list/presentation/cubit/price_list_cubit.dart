import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricehup/features/price_list/domain/usecases/get_categories.dart';
import 'package:pricehup/features/price_list/presentation/cubit/price_list_state.dart';

class PriceListCubit extends Cubit<PriceListState> {
  final GetCategories getCategories;

  PriceListCubit({required this.getCategories}) : super(PriceListInitial()) {
    loadCategories();
  }

  Future<void> loadCategories() async {
    emit(PriceListLoading());
    final result = await getCategories();
    result.fold(
      (failure) => emit(PriceListError(failure.message)),
      (categories) => emit(PriceListLoaded(categories)),
    );
  }
}
