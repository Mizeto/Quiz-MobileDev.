import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Add_Form extends StatefulWidget {
  @override
  State<Add_Form> createState() => _Add_FormState();
}

class _Add_FormState extends State<Add_Form> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedMood = "😊 Happy";

  CollectionReference diaryCollection = FirebaseFirestore.instance.collection(
    'Diary',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Diary',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            foreground:
                Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Enter diary title",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Write about your day...",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Mood",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: selectedMood,
                items:
                    [
                      "😊 Happy",
                      "😢 Sad",
                      "😡 Angry",
                      "😴 Sleepy",
                      "🤔 Thoughtful",
                      "😍 In Love",
                    ].map((mood) {
                      return DropdownMenuItem(value: mood, child: Text(mood));
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMood = value!;
                  });
                },
                decoration: InputDecoration(border: OutlineInputBorder()),
              ),

              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    diaryCollection.add({
                      'title': titleController.text,
                      'description': descriptionController.text,
                      'mood': selectedMood,
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: theme.primary,
                    foregroundColor: theme.onPrimary,
                  ),
                  child: Text("Save Diary"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
