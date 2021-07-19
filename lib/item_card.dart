import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:og_flutter/api_service.dart';
import 'package:og_flutter/detail_screen.dart';

class ItemCard extends StatelessWidget {
  final ListResult result;

  const ItemCard(this.result, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(result.name),
        trailing: Icon(Icons.chevron_right),
        onTap: () {
          Modular.to.pushNamed("${DetailScreen.routeName}/${result.id}");
        },
      ),
    );
  }
}
