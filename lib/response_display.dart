import 'package:flutter/material.dart';
import '/app_state.dart';
import 'package:provider/provider.dart';
import 'to_do.dart';
import 'dart:convert';

class ResponseDisplay extends StatefulWidget {
  ResponseDisplay({Key key}) : super(key: key);

  @override
  _ResponseDisplayState createState() => _ResponseDisplayState();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _ResponseDisplayState extends State<ResponseDisplay> {
  List<ToDo> _aggregatedToDos = new List<ToDo>.empty(growable: true);

  void getToDosfromApi() async {
    AppState().fetchData().then((response) {
      // window.console.debug(response);

      setState(() {
        Iterable list = json.decode(response);
        _aggregatedToDos = list.map((model) => ToDo.fromJson(model)).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getToDosfromApi();
  }

  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: appState.isFetching
          ? CircularProgressIndicator()
          : appState.fetchData() != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _aggregatedToDos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(_aggregatedToDos[index].name),
                    );
                  },
                )
              : Text("Press Button above to fetch ToDos"),
    );
  }
}
