import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/controller.dart';


class LikedNotesPage extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liked Notes')),
      body: Obx(() {
        return ListView.builder(
          itemCount: noteController.likedNotes.length,
          itemBuilder: (context, index) {
            final note = noteController.likedNotes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.note),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => noteController.removeLikedNote(note),
              ),
            );
          },
        );
      }),
    );
  }
}
