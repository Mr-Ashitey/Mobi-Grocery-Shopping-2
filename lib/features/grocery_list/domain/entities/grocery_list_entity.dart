import 'package:equatable/equatable.dart';

import 'grocery_list_item_entity.dart';

class GroceryListEntity extends Equatable {
  final int? id;
  final String name;
  final List<GroceryListItemEntity> groceryListItems;

  const GroceryListEntity(
      {this.id,
      required this.name,
      this.groceryListItems = const <GroceryListItemEntity>[]});

  @override
  List<Object?> get props => [id, name, groceryListItems];
}
