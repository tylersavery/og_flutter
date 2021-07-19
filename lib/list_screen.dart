import 'package:flutter/material.dart';
import 'package:og_flutter/api_service.dart';
import 'package:og_flutter/item_card.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/';

  const ListScreen({Key? key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListResult> _items = [];
  bool _isLoading = true;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final response =
        await Provider.of<ApiService>(context, listen: false).list();

    setState(() {
      _items = response.results;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return ItemCard(item);
              }),
    );
  }
}
