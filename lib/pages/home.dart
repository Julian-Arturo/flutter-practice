import 'dart:io';

import 'package:app1_band_name_app/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Band> bands = [
    Band(id: "1", name: "Metalica", votes: 5),
    Band(id: "2", name: "Pop", votes: 6),
    Band(id: "3", name: "Bachata", votes: 7),
    Band(id: "4", name: "Rock", votes: 3),
    Band(id: "5", name: "Rap", votes: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          "BandName",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(
          bands[i],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: _addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band bands) {
    return Dismissible(
      key: Key(bands.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print("direccion $direction");
        //TODO: LLamar el borrador en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Delete Band",
              style: TextStyle(color: Colors.white),
            )),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(bands.name.substring(0, 2)),
        ),
        title: Text(bands.name),
        trailing: Text(
          "${bands.votes}",
          style: const TextStyle(fontSize: 20),
        ),
        onTap: () {
          print(bands.name);
        },
      ),
    );
  }

  _addNewBand() {
    final textController = TextEditingController();

    if (!Platform.isAndroid) {
      showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text("New Band name"),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("Add"),
                onPressed: () => addBandToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: const Text("Dismiss"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        },
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("New band name : "),
          content: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            controller: textController,
          ),
          actions: [
            MaterialButton(
              elevation: 1,
              textColor: Colors.blue,
              onPressed: () {
                addBandToList(textController.text);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  void addBandToList(String name) {
    // print(name);
    if (name.length > 1) {
      bands.add(
        Band(
          id: DateTime.now().toString(),
          name: name,
          votes: 0,
        ),
      );
    }
    Navigator.pop(context);
  }
}
