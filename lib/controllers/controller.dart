import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/modelclass.dart';
import 'dbtable.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var likedNotes = <Note>[].obs;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DatabaseHelper dbHelper = DatabaseHelper();

  @override
  void onInit() {
    fetchNotes();
    fetchLikedNotes();
    super.onInit();
  }

  void fetchNotes() {
    firestore.collection('notes').snapshots().listen((snapshot) {
      notes.clear();
      for (var doc in snapshot.docs) {
        notes.add(Note.fromMap(doc.data()..['id'] = doc.id));
      }
    });
  }

  Future<void> addNote(String title, String note) async {
    var docRef = await firestore.collection('notes').add({
      'title': title,
      'note': note,
    });
    notes.add(Note(id: docRef.id, title: title, note: note));
  }

  Future<void> updateNote(String id, String title, String note) async {
    await firestore.collection('notes').doc(id).update({
      'title': title,
      'note': note,
    });
    final index = notes.indexWhere((element) => element.id == id);
    if (index != -1) {
      notes[index] = Note(id: id, title: title, note: note);
    }
  }

  Future<void> deleteNote(Note note) async {
    await firestore.collection('notes').doc(note.id).delete();
    notes.remove(note);
  }

  Future<void> addToLikedNotes(Note note) async {
    await dbHelper.insertLikedNote(note.toMap());
    likedNotes.add(note);
  }

  Future<void> fetchLikedNotes() async {
    likedNotes.clear();
    final storedNotes = await dbHelper.getLikedNotes();
    likedNotes.addAll(storedNotes.map((note) => Note.fromMap(note)).toList());
  }

  Future<void> removeLikedNote(Note note) async {
    await dbHelper.deleteLikedNote(note.id);
    likedNotes.remove(note);
  }
}

