import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    NotesApp(notes: []),
  );
}

final ThemeData notesTheme = ThemeData(
  primarySwatch: Colors.yellow,
  primaryColor: Colors.grey[800],
  primaryColorBrightness: Brightness.light,
);

class NotesPage extends StatelessWidget {
  // [
  // Note('Note1', 'note1'),
  // Note('Note2','note2'),
  // Note('Note3','note3')
  // ];
  const NotesPage({Key? key, required this.notes}) : super(key: key);

  final List<Note> notes;

  Widget notesCard(note) {
    return Card(
        margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        color: Colors.yellow,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(note.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey[000],
                    )),
                SizedBox(height: 16.0),
                Text(note.content,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[800]))
              ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[150],
      appBar: AppBar(
        title: Text('My notes'),
        centerTitle: true,
        backgroundColor: Colors.yellow[700],
      ),
      body: Column(
        children: notes.map((note) => notesCard(note)).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNoteScreen(notes: notes)),
          );
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Note {
  final String title;
  final String content;
  Note(this.title, this.content);
}

class NotesApp extends StatelessWidget {
  List<Note> notes;

  List<Note> getNotes() {
    return notes;
  }

  void setNotes(List<Note> notes) {
    this.notes = notes ?? [];
  }

  NotesApp({Key? key, required this.notes}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var myNotes = notes ?? [];
    return MaterialApp(
      home: NotesPage(notes: myNotes),
      theme: notesTheme,
      routes: {
        '/add-note': (context) => AddNoteScreen(notes: myNotes),
      },
    );
  }
}

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key, required this.notes}) : super(key: key);

  final List<Note> notes;

  @override
  State<AddNoteScreen> createState() => _AddNoteScreen();
}

class _AddNoteScreen extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  List<Note> _notes = [];
  final FocusNode _focusNode = FocusNode();
  bool _isComposingTitle = false;
  bool _isComposingContent = false;
  void _handleSubmitted(String title, String content) {
    _titleController.clear();
    _contentController.clear();
    setState(() {
      // NEW
      _isComposingTitle = false;
      _isComposingContent = false; // NEW
    }); // NEW

    var note = Note(title, content // NEW
        ); // NEW
    setState(() {
      // NEW
      _notes.insert(_notes.length, note); // NEW
    });
    _focusNode.requestFocus(); // NEW
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotesPage(notes: _notes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('adding note');
    _notes = widget.notes;
    // Size size = MediaQuery.of(context).size;
    return Container(

      child: Column(

        children: [
          Flexible(
            child: Scaffold(
              appBar: AppBar(
                title: Text('new note'),
                backgroundColor: Colors.yellow[650],
              ),
              body: TextField(
                // decoration: InputDecoration(
                //     border: OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.teal)),
                //     hintText: 'Tell us about yourself',
                //     helperText: 'Keep it short, this is just a demo.',
                //     labelText: 'Life story',
                //     suffixStyle: const TextStyle(color: Colors.green)
                // ),
                decoration: const InputDecoration.collapsed(
                    hintText: 'Write note title'),

                controller: _titleController,
                onChanged: (text) {
                  // NEW
                  setState(() {
                    // NEW
                    _isComposingTitle = text.isNotEmpty; // NEW
                  });
                  // NEW
                },
                // NEW
                focusNode: _focusNode,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: Scaffold(
              body: TextField(
                controller: _contentController,
                onChanged: (text) {
                  // NEW
                  setState(() {
                    // NEW
                    _isComposingContent = text.isNotEmpty; // NEW
                  }); // NEW
                }, // NEW

                decoration: const InputDecoration.collapsed(
                    hintText: 'Write note content'),
                focusNode: _focusNode,
              ),
            ),
          ),
          
          Flexible(
            child: Scaffold(
            body: IconButton(                                               // MODIFIED
              icon: const Icon(Icons.save),
              onPressed: _isComposingTitle && _isComposingContent ?
                  () =>  _handleSubmitted(_titleController.text, _contentController.text) : null,
            ),
          )
          )
        ],

      ),
    );
  }
}
