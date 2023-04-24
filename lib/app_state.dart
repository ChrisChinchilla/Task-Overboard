import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class AppState with ChangeNotifier {
  // AppState();
  bool _isFetching = false;
  bool get isFetching => _isFetching;
  String _aggregatedTodos = "";

  Future fetchData() async {
    String _trelloJsonResponse = "";
    String _githubJsonResponse = "";
    _isFetching = true;
    Uri _trelloURL = Uri.parse(dotenv.env['TRELLO_URL']);
    Uri _githubURL = Uri.parse(dotenv.env['GITHUB_URL']);
    String _githubTOKEN = dotenv.env['GITHUB_TOKEN'];

// TODO: better way to do all this
// TODO: Pings a lot
    try {
      final trelloResponse = await http.get(_trelloURL);
      if (trelloResponse.statusCode == 200) {
        _isFetching = true;
        _trelloJsonResponse = trelloResponse.body;
        _aggregatedTodos = _aggregatedTodos +
            _trelloJsonResponse.substring(0, _trelloJsonResponse.length - 1);
        // window.console.debug(_aggregatedTodos);

        // notifyListeners();
      }
    } catch (exception, stackTrace) {}

    try {
      final githubResponse = await http.get(_githubURL, headers: {
        'Authorization': 'token $_githubTOKEN',
        'Accept': 'application/vnd.github.text+json'
      });
      if (githubResponse.statusCode == 200) {
        _isFetching = true;
        _githubJsonResponse = githubResponse.body;
        _aggregatedTodos = _aggregatedTodos +
            "," +
            _githubJsonResponse.substring(1, _githubJsonResponse.length - 1);
        // window.console.debug(_aggregatedTodos);

        // notifyListeners();
      }
    } catch (exception, stackTrace) {}

    _isFetching = false;
    notifyListeners();
    // window.console.debug(_aggregatedTodos);
    return _aggregatedTodos;
  }
}
