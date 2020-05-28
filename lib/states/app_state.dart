import 'dart:convert';
import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite_example/models/note_model.dart';
import 'package:flutter/material.dart';

class NoteDataState extends ChangeNotifier {
  Client appwriteClient;
  Database database;
  Account account;
  String _projectId = '5ece91e405eaf';
  String _userId;
  String _noteColloctionId = '5ece925536a1d';

  List<NoteModel> _noteList = [];

  List<NoteModel> get totalNoteList => _noteList;

  init() {
    appwriteClient = Client(selfSigned: true);
    appwriteClient
        .setEndpoint('http://10.0.2.2/v1')
        .setProject(_projectId)
        .selfSigned;
    database = Database(appwriteClient);
    account = Account(appwriteClient);
  }

  login({String username, String password}) {
    Future result = account.createSession(
      email: '${username}',
      password: '${password}',
    );

    result.then((response) {
      getNoteData();
      log(response.toString());
    }).catchError((error) {
      log(error.toString());
    });
  }

  logout({String username, String password}) {
    var session;
    account.getSessions().then((value) => {session = value});
    Future result = account.deleteSession(
      sessionId: session,
    );

    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error);
    });
  }

  getUserId() {
    return _userId;
  }

  getUserInfo() {
    Future result = account.get();
    result.then((response) {
      _userId = jsonDecode(response.toString())['roles'][1].toString();
      log(_userId);
      log(response.toString());
      getNoteData();
      notifyListeners();
    }).catchError((error) {
      log(error.toString());
    });
  }

  addNoteData({NoteModel noteModel, String userId}) {
    appwriteClient.setProject(_projectId);
    Future result = database.createDocument(
      collectionId: '$_noteColloctionId',
      data: noteModel.toJson(),
      read: ['*'],
      write: [
        '$_userId'
      ], //// Disclaim, everyone can write sine I set to '*' as just demo
    );

    result.then((response) {
      log('Create document: ' + response.toString());

      getNoteData(); //// Refresh document list
    }).catchError((error) {
      log('Create document: ' + error.toString());
    });
  }

  getNoteData() {
    appwriteClient.setProject(_projectId);
    Future result = database.listDocuments(
      orderField: 'timestamp',
      orderType: OrderType.desc,
      collectionId: '$_noteColloctionId',
    );

    result.then((response) {
      log('Get getNoteData: ' +
          jsonDecode(response.toString())['documents'].toString());
      _noteList = (jsonDecode(response.toString())['documents'] as List)
          .map((i) => NoteModel.fromJson(i))
          .toList();
      notifyListeners();
    }).catchError((error) {
      log('Get getNoteData: ' + error.toString());
    });
  }

  List<NoteModel> getNoteList() {
    log('Get getNoteList:' + _noteList.toString());
    return _noteList;
  }

  updateNoteData({NoteModel noteModel, String userId}) {
    log(noteModel.toJson().toString());
    appwriteClient.setProject(_projectId);
    Future result = database.updateDocument(
      documentId: noteModel.id,
      collectionId: '$_noteColloctionId',
      data: noteModel.toJson(),
      read: ['*'],
      write: [
        '$_userId'
      ], //// Disclaim, everyone can write sine I set to '*' as just demo
    );

    result.then((response) {
      log('Update document: ' + response.toString());
      getNoteData();
    }).catchError((error) {
      log('Update document: ' + error.toString());
    });
  }

  deleteNoteData({NoteModel noteModel}) {
    appwriteClient.setProject(_projectId);
    Future result = database.deleteDocument(
      documentId: noteModel.id,
      collectionId: '$_noteColloctionId',
    );

    result.then((response) {
      log('Delete document: ' + response.toString());
      getNoteData();
    }).catchError((error) {
      log('Delete document: ' + error.toString());
    });
  }
}
