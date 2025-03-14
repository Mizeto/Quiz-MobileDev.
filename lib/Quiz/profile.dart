import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Profile_Screen extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> signOutUser(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login_Screen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user?.photoURL ?? 'https://example.com/default_avatar.png',
              ),
            ),

            SizedBox(height: 10),
            Text(
              user?.displayName ?? "No Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 5),
            Text(
              user?.email ?? "No Email",
              style: TextStyle(fontSize: 16, color: theme.onSurface),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => signOutUser(context),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text("Log Out"),
            ),
          ],
        ),
      ),
    );
  }
}
