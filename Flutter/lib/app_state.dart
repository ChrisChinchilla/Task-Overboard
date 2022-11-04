import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  Uri _trelloURL = Uri.parse(dotenv.env['TRELLO_URL']);
  // Uri _asanaURL = Uri.parse(dotenv.env['ASANA_URL']);
  Uri _githubURL = Uri.parse(dotenv.env['GITHUB_URL']);
  // String _asanaTOKEN = dotenv.env['ASANA_TOKEN'];
  String _githubTOKEN = dotenv.env['GITHUB_TOKEN'];

  AppState();
  String _trelloJsonResponse = "";
  // String _asanaJsonResponse = "";
  String _githubJsonResponse = "";
  bool _isFetching = false;
  bool get isFetching => _isFetching;

  Future<void> fetchData() async {
    _isFetching = true;
    notifyListeners();

// TODO: better way to do all this

    var trelloResponse = await http.get(_trelloURL);
    if (trelloResponse.statusCode == 200) {
      _trelloJsonResponse = trelloResponse.body;
    }

    // var asanaResponse = await http
    //     .get(_asanaURL, headers: {'Authorization': 'Bearer $_asanaTOKEN'});
    // if (asanaResponse.statusCode == 200) {
    //   _asanaJsonResponse = asanaResponse.body;
    // }

    var githubResponse = await http
        .get(_githubURL, headers: {'Authorization': 'token $_githubTOKEN'});
    if (githubResponse.statusCode == 200) {
      _githubJsonResponse = githubResponse.body;
    }

    _isFetching = false;
    notifyListeners();
  }
// TODO: Objects maybe?
// Map userMap = jsonDecode(jsonString);
// var user = User.fromJson(userMap);

  List<dynamic> getResponseJson() {
    List<dynamic> json = [];
    if (_trelloJsonResponse.isNotEmpty) {
      json.addAll(jsonDecode(_trelloJsonResponse));
    }
    // if (_asanaJsonResponse.isNotEmpty) {
    //   Map asanaTasks = jsonDecode(_asanaJsonResponse);
    //   json.addAll(asanaTasks['data']);
    // }
    if (_githubJsonResponse.isNotEmpty) {
      json.addAll(jsonDecode(_githubJsonResponse));
    }
// TODO: Fails?
    // json.sort();
    return json;
    // return null;
  }
}
