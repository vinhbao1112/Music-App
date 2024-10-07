import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:fluter_1/data/model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Song>?> loadData();
}

class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    const url = 'https://thantrieu.com/resources/braniumapis/songs.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final data = jsonDecode(bodyContent) as Map<String, dynamic>;
      if (data.containsKey('songs')) {
        // Fix: Kiểm tra khóa 'songs'
        final songs = data['songs'] as List<dynamic>;
        return songs.map((song) => Song.fromJson(song)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load data');
    }
  }
}

// class LocalDataSource implements DataSource {
//   @override
//   Future<List<Song>?> loadData() async {
//     final String response = await rootBundle.loadString('assets/songs.json');
//     final jsonBody = jsonDecode(response) as Map;
//     var songList = jsonBody['songs'] as List;
//     List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
//     return songs;
//   }
// }
class LocalDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async {
    return [];
  }
}

// class RemoteDataSource implements DataSource {
//   @override
//   Future<List<Song>?> loadData() async {
//     return [];
//   }
// }
