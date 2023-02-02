import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:music_app/home/domain/entry.dart' as entry_data;

Future<List<entry_data.Entry>> fetchAlbumEntries() async {
  final response = await http.get(Uri.parse('https://itunes.apple.com/us/rss/topalbums/limit=100/json'));

  if (response.statusCode == 200) {
    List<entry_data.Entry> entriesList = [];
    for (var entry in jsonDecode(response.body)["feed"]["entry"]) {
      entriesList.add(entry_data.Entry.fromJson(entry));
    }
    return entriesList;
  } else {
    throw Exception('Failed to load data');
  }
}
