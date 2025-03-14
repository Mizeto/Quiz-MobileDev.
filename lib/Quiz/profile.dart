import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // ✅ นำเข้า Login_Screen

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
    final theme = Theme.of(context).colorScheme; // ✅ รองรับ Dark Mode

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
            // ✅ **Avatar ของผู้ใช้**
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                user?.photoURL ?? 'https://example.com/default_avatar.png',
              ),
            ),
            SizedBox(height: 10),

            // ✅ **แสดงชื่อผู้ใช้**
            Text(
              user?.displayName ?? "No Name",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),

            // ✅ **แสดงอีเมล**
            Text(
              user?.email ?? "No Email",
              style: TextStyle(fontSize: 16, color: theme.onSurface),
            ),
            SizedBox(height: 20),

            // ✅ **ปุ่ม Logout**
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
