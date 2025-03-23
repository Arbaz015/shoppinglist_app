import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shoppinglist_app/data/categories.dart';
import 'package:shoppinglist_app/data/dummy_items.dart';
import 'package:shoppinglist_app/model/category.dart';
import 'package:shoppinglist_app/model/grocery_items.dart';
import 'package:shoppinglist_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  @override
  State<GroceryList> createState() {
    // TODO: implement createState
    return _GroceryListState();
  }
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  String? _error;
  var _isLoading = true;
  void _loadItems() async {
    final url = Uri.https('shopping-list-5690c-default-rtdb.firebaseio.com',
        'shopping-list.json');

    try {
      final response = await http.get(url);
      print(response.body);

      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later..';
        });
      }

      if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      final Map<String, dynamic> listData = json.decode(response.body);
      final List<GroceryItem> _loadedItems = [];

      for (final item in listData.entries) {
        final category = categories.entries
            .firstWhere(
                (catItem) => catItem.value.title == item.value['category'])
            .value;
        _loadedItems.add(GroceryItem(
            id: item.key,
            name: item.value['name'],
            category: category,
            quantity: item.value['quantity']));
      }

      setState(() {
        _groceryItems = _loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong. Please try again later..';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _addItem() async {
    final newItem = await Navigator.push<GroceryItem>(
        context, MaterialPageRoute(builder: (context) => const NewItem()));

    _loadItems();
  }

  void _removeItem(GroceryItem item) async {
    final index = _groceryItems.indexOf(item);

    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https('-list-5690c-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      setState(() {
        groceryItems.insert(index, item);
      });

      setState(() {
        _groceryItems.remove(item);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.name} dismissed'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              _undoDelete(item);
            },
          ),
        ),
      );
    }
  }

  void _undoDelete(GroceryItem item) {
    final index = _groceryItems.indexOf(item);
    final url = Uri.https('shopping-list-5690c-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = http.put(url);

    setState(() {
      groceryItems.insert(index, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'No items added yet!',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          key: ValueKey(_groceryItems[index].id),
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          child: ListTile(
              title: Text(_groceryItems[index].name),
              leading: Container(
                height: 24,
                width: 24,
                color: _groceryItems[index].category.color,
              ),
              trailing: Text(
                _groceryItems[index].quantity.toString(),
              )),
        ),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
