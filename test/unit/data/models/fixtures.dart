import 'dart:convert';
import 'dart:io';

Map<String, dynamic> loadFixtureJson(String name) =>
    jsonDecode(
          File('test/unit/data/models/fixtures/$name.json').readAsStringSync(),
        )
        as Map<String, dynamic>;

List<dynamic> loadFixtureList(String name) =>
    jsonDecode(
          File('test/unit/data/models/fixtures/$name.json').readAsStringSync(),
        )
        as List<dynamic>;
