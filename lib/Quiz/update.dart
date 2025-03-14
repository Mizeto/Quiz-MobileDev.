import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Update_Form extends StatefulWidget {
  @override
  State<Update_Form> createState() => _Update_FormState();
}

class _Update_FormState extends State<Update_Form> {
  CollectionReference diaryCollection =
      FirebaseFirestore.instance.collection('Diary');

  @override
  Widget build(BuildContext context) {
    final diaryData = ModalRoute.of(context)!.settings.arguments as dynamic;
    final titleController = TextEditingController(text: diaryData['title']);
    final descriptionController =
        TextEditingController(text: diaryData['description']);
    String selectedMood = diaryData['mood'] ?? "😊 Happy"; // ✅ ดึงค่ามู้ด

    final theme = Theme.of(context).colorScheme; // ✅ รองรับ Dark Mode

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Diary',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            foreground: Paint()
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
              // ✅ **Title (ไม่สามารถแก้ไข)**
              Text(
                "Title",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: titleController,
                readOnly: true, // ✅ ห้ามแก้ไขหัวเรื่อง
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // ✅ **Description Input**
              Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Edit your diary...",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // ✅ **Mood Selection**
              Text(
                "Mood",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              DropdownButtonFormField<String>(
                value: selectedMood,
                items: [
                  "😊 Happy",
                  "😢 Sad",
                  "😡 Angry",
                  "😴 Sleepy",
                  "🤔 Thoughtful",
                  "😍 In Love",
                ].map((mood) {
                  return DropdownMenuItem(
                    value: mood,
                    child: Text(mood),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMood = value!;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 30),

              // ✅ **Update Diary Button**
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    diaryCollection.doc(diaryData.id).update({
                      'description':
                          descriptionController.text, // ✅ บันทึกคำอธิบาย
                      'mood': selectedMood, // ✅ บันทึกมู้ด
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    backgroundColor: theme.primary,
                    foregroundColor: theme.onPrimary,
                  ),
                  child: Text("Update Diary"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
