// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Mont Laferte', votes: 5),
    Band(id: '2', name: 'Alejandra Mix', votes: 3),
    Band(id: '3', name: 'Porfirio Aivar', votes: 2),
    Band(id: '4', name: 'Rosita de ESpinar', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandTile(bands[i])),
      floatingActionButton: FloatingActionButton(
          // ignore: sort_child_properties_last
          child: Icon(Icons.add),
          elevation: 1,
          onPressed: addNewBand),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        // ignore: avoid_print
        print('direction: $direction');
        // ignore: avoid_print
        print('id: ${band.id}');
        // ignore: todo
        //TODO llamar el borrado en el server
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle(color: Colors.white)),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          // ignore: sort_child_properties_last
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text(
          '${band.votes}',
          style: TextStyle(fontSize: 20),
        ),
        onTap: () {
          // ignore: avoid_print
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    // ignore: unnecessary_new
    final textController = new TextEditingController();

    if (Platform.isAndroid) {
      //Android
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('New band name'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                    // ignore: sort_child_properties_last
                    child: Text('Add'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed: () => addBandToList(textController.text))
              ],
            );
          });
    }

    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('New band Name:'),
            content: CupertinoTextField(),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context))
            ],
          );
        });
  }

  void addBandToList(String name) {
    // ignore: avoid_print
    print(name);

    if (name.length > 1) {
      //Podemos agregar
      // ignore: unnecessary_this
      this
          .bands
          // ignore: unnecessary_new
          .add(new Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
