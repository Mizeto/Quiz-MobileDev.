import 'package:firebase_auth/firebase_auth.dart';
import '../Quiz/login.dart';
import '../Quiz/main.dart';
import 'package:flutter/material.dart';
import '../Quiz/home.dart';

class Authen_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Home_Screen(); // ถ้าผู้ใช้ล็อกอินแล้ว
          } else {
            return Login_Screen(); // ถ้ายังไม่ได้ล็อกอิน
          }
        },
      ),
    );
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../Quiz/home.dart';
// import '../Quiz/login.dart';

// class Authen_Screen extends StatefulWidget {
//   @override
//   _Authen_ScreenState createState() => _Authen_ScreenState();
// }

// class _Authen_ScreenState extends State<Authen_Screen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 2), () {
//       checkAuthentication();
//     });
//   }

//   void checkAuthentication() {
//     FirebaseAuth.instance.authStateChanges().listen((User? user) {
//       if (user == null) {
//         Navigator.pushReplacementNamed(context, '/'); // ไปหน้า Login
//       } else {
//         Navigator.pushReplacementNamed(context, '/home'); // ไปหน้า Home
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme; // ✅ รองรับ Dark Mode

//     return Scaffold(
//       body: Center(
//         child: AnimatedContainer(
//           duration: Duration(milliseconds: 500),
//           curve: Curves.easeInOut,
//           padding: EdgeInsets.all(24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // ✅ **โลโก้ หรือไอคอนแอป**
//               Icon(
//                 Icons.security,
//                 size: 100,
//                 color: theme.primary,
//               ),
//               SizedBox(height: 20),

//               // ✅ **ข้อความต้อนรับ**
//               Text(
//                 "Authenticating...",
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   foreground: Paint()
//                     ..shader = LinearGradient(
//                       colors: [Colors.blue, Colors.purple],
//                     ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
//                 ),
//               ),
//               SizedBox(height: 20),

//               // ✅ **แสดง Loading**
//               CircularProgressIndicator(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
