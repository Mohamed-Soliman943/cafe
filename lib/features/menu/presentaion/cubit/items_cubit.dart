import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/item_model.dart';
import '../../data/services/item_service.dart';


part 'items_state.dart';

class ItemsCubit extends Cubit<ItemsState> {
  final ItemService itemService;

  ItemsCubit({required this.itemService}) : super(ItemsInitial());

  Future<void> fetchItems(String categoryUrl) async {
    print('cubit fetchItems called----------------------------');
    emit(ItemsLoading());
    try {
      final items = await itemService.fetchItems(categoryUrl);
      emit(ItemsSuccess(items));
    } catch (e) {
      emit(ItemsError(e.toString()));
    }
  }
}