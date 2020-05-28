import 'package:appwrite_example/models/note_model.dart';
import 'package:appwrite_example/pages/note_form.dart';
import 'package:appwrite_example/states/app_state.dart';
import 'package:appwrite_example/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appnote'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => NoteForm()));
        },
        child: Icon(Icons.edit),
      ),
      body: Consumer<NoteDataState>(
        builder: (context, noteList, child) {
          return ListView.builder(
            itemCount: noteList.totalNoteList.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListTile(
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NoteForm(
                              noteModel: noteList.totalNoteList[index],
                            ),
                          ),
                        );
                      },
                    ),
                    title: Text("${noteList.totalNoteList[index].title}",
                        style: TextStyle(fontSize: 18)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Text("${noteList.totalNoteList[index].message}",
                            style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 8,
                        ),
                        noteList.totalNoteList[index].lastUpdate == null
                            ? Text(
                                "created at ${formatDatetime(noteList.totalNoteList[index].timestamp)}",
                                style: TextStyle(fontSize: 12),
                              )
                            : Text(
                                "last updated ${formatDatetime(noteList.totalNoteList[index].lastUpdate)}",
                                style: TextStyle(fontSize: 12),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
