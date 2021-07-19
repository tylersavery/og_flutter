import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const API_BASE_URL = 'https://pokeapi.co/api/v2';
const LIMIT = 100;

class PaginatedResponse<T> {
  final List<T> results;
  final String? next;
  final String? previous;
  final int count;

  PaginatedResponse({
    required this.results,
    this.next,
    this.previous,
    required this.count,
  });
}

class ListResult {
  final String name;
  final String url;

  ListResult({
    required this.name,
    required this.url,
  });

  int get id {
    final parts = this.url.split('/');
    return int.parse(parts[parts.length - 2]);
  }
}

class ApiService with ChangeNotifier, DiagnosticableTreeMixin {
  Future<Map<String, dynamic>> _getHttp(String path, [params]) async {
    try {
      final url = "$API_BASE_URL/$path";
      var response = await Dio().get(url, queryParameters: params ?? {});
      return response.data;
    } catch (e) {
      print(e);
      return {};
    }
  }

  Future<PaginatedResponse<ListResult>> list([int page = 1]) async {
    final params = {
      'page': page,
      'offset': (page - 1) * LIMIT,
      'limit': LIMIT,
    };

    final data = await this._getHttp('pokemon', params);

    final results = data['results']
        .map<ListResult>(
          (item) => ListResult(
            name: item['name'],
            url: item['url'],
          ),
        )
        .toList();

    return PaginatedResponse<ListResult>(
      count: data['count'],
      results: results,
      next: data['next'],
      previous: data['previous'],
    );
  }

  Future<Map<dynamic, dynamic>>? detail(int id) async {
    final path = 'pokemon/$id';
    final data = await this._getHttp(path);
    return data;
  }
}
