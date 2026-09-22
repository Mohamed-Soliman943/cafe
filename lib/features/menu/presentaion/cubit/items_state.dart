part of 'items_cubit.dart';

@immutable
sealed class ItemsState {}

final class ItemsInitial extends ItemsState {}
final class ItemsLoading extends ItemsState {}
final class ItemsSuccess extends ItemsState {
  final List<ItemModel> items;
  ItemsSuccess(this.items);
}
class ItemsError extends ItemsState {
  final String message;
  ItemsError(this.message);
}

