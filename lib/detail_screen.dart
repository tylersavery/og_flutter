import 'package:flutter/material.dart';
import 'package:og_flutter/api_service.dart';
import 'package:provider/provider.dart';

class DetailScreenArguments {
  final int id;

  DetailScreenArguments(this.id);
}

class DetailScreen extends StatefulWidget {
  final int id;
  static const routeName = '/detail';
  const DetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<dynamic, dynamic>? _item;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _init();
    });
  }

  Future<void> _init() async {
    final item =
        await Provider.of<ApiService>(context, listen: false).detail(widget.id);

    setState(() {
      _item = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_item == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final String name = _item!['name'];

    final String image =
        _item!['sprites']['other']['official-artwork']['front_default'];
    final int number = _item!['order'];

    return Scaffold(
      appBar: AppBar(
        title: Text(name.toUpperCase()),
      ),
      body: Column(
        children: [
          Image.network(
            image,
            width: double.infinity,
            height: 300,
            fit: BoxFit.contain,
            isAntiAlias: false,
          ),
          Text("#$number")
        ],
      ),
    );
  }
}
