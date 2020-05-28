import 'package:appwrite_example/models/note_model.dart';
import 'package:appwrite_example/states/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoteForm extends StatefulWidget {
  NoteModel noteModel;

  NoteForm({Key key, this.noteModel}) : super(key: key);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final titleTextController = TextEditingController();
  final messageTextController = TextEditingController();

  @override
  void initState() {
    _initTextField();
    super.initState();
  }

  _initTextField() {
    titleTextController.text =
        widget.noteModel != null ? widget.noteModel.title : '';
    messageTextController.text =
        widget.noteModel != null ? widget.noteModel.message : '';
  }

  @override
  void dispose() {
    titleTextController.dispose();
    messageTextController.dispose();
    super.dispose();
  }

  _submitNote() {
    if ((titleTextController.text == '') ||
        (messageTextController.text == '')) {
      return null;
    }

    var _appState = Provider.of<NoteDataState>(context, listen: false);
    if (widget.noteModel == null) {
      NoteModel _noteModel = NoteModel(
          title: titleTextController.text,
          message: messageTextController.text,
          timestamp: DateTime.now().millisecondsSinceEpoch,
          isDone: false);
      Provider.of<NoteDataState>(context, listen: false)
          .addNoteData(noteModel: _noteModel, userId: _appState.getUserId());
    } else if (widget.noteModel != null) {
      widget.noteModel.lastUpdate = DateTime.now().millisecondsSinceEpoch;
      widget.noteModel.title = titleTextController.text;
      widget.noteModel.message = titleTextController.text;
      Provider.of<NoteDataState>(context, listen: false).updateNoteData(
          noteModel: widget.noteModel, userId: _appState.getUserId());
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            widget.noteModel == null ? Text('Add new Note') : Text('Edit Note'),
        actions: [
          widget.noteModel != null
              ? IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Provider.of<NoteDataState>(context, listen: false)
                        .deleteNoteData(noteModel: widget.noteModel);
                    Navigator.of(context).pop();
                  },
                )
              : Container()
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                autofocus: true,
                controller: titleTextController,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                maxLines: 10,
                autofocus: true,
                controller: messageTextController,
                decoration: InputDecoration(hintText: 'message'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MaterialButton(
                onPressed: _submitNote,
                color: Colors.pink,
                child: Text(
                  widget.noteModel == null ? 'Add Note' : 'Update Note',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
