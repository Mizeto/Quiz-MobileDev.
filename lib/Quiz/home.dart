import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'add.dart';
import 'update.dart';
import 'profile.dart';

class Home_Screen extends StatefulWidget {
  @override
  _Home_ScreenState createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  CollectionReference diaryCollection = FirebaseFirestore.instance.collection(
    'Diary',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Diary",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            foreground:
                Paint()
                  ..shader = LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle, size: 28),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile_Screen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Add_Form()),
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Colors.amber,
        child: Icon(Icons.add, color: Colors.white),
      ),
      body: StreamBuilder(
        stream: diaryCollection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          var diaries = snapshot.data!.docs;

          return ListView.builder(
            itemCount: diaries.length,
            padding: EdgeInsets.all(8.0),
            itemBuilder: (context, index) {
              var diary = diaries[index];

              return Slidable(
                startActionPane: ActionPane(
                  motion: StretchMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        String shareContent =
                            "📖 ${diary['title']}\n${diary['description']}\nMood: ${diary['mood']}";
                      },
                      backgroundColor: Colors.green,
                      icon: Icons.share,
                      label: 'Share',
                    ),
                  ],
                ),

                endActionPane: ActionPane(
                  motion: DrawerMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Update_Form(),
                            settings: RouteSettings(arguments: diary),
                          ),
                        );
                      },
                      backgroundColor: Colors.blue,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),

                    SlidableAction(
                      onPressed: (context) {
                        diaryCollection.doc(diary.id).delete();
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),

                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          diary['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: theme.primary,
                          ),
                        ),

                        SizedBox(height: 5),
                        Text(
                          diary['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: theme.onSurface,
                          ),
                        ),

                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Mood: ${diary['mood']}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
