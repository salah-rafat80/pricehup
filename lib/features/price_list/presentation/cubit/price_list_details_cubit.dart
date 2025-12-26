import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pricehup/features/price_list/domain/entities/product_item.dart';
import 'package:pricehup/features/price_list/domain/usecases/get_price_list_details.dart';

part 'price_list_details_state.dart';

class PriceListDetailsCubit extends Cubit<PriceListDetailsState> {
  final GetPriceListDetails getPriceListDetails;

  PriceListDetailsCubit({required this.getPriceListDetails})
    : super(PriceListDetailsInitial());

  Future<void> loadPriceListDetails(int priceListId) async {
    emit(PriceListDetailsLoading());
    final result = await getPriceListDetails(priceListId);
    result.fold(
      (failure) => emit(PriceListDetailsError(failure.message)),
      (items) => emit(PriceListDetailsLoaded(items)),
    );
  }
}
