import 'package:flutter/material.dart';
import 'package:shoppinglist_app/data/categories.dart';
import 'package:shoppinglist_app/data/dummy_items.dart';
import 'package:shoppinglist_app/model/category.dart';
import 'package:shoppinglist_app/model/grocery_items.dart';
import 'package:shoppinglist_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addItem() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NewItem()));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
            title: Text(groceryItems[index].name),
            leading: Container(
              height: 24,
              width: 24,
              color: groceryItems[index].category.color,
            ),
            trailing: Text(
              groceryItems[index].quantity.toString(),
            )),
      ),
    );
  }
}
