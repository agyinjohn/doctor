import 'package:doctor/firebase_options.dart';
import 'package:doctor/route.dart';
import 'package:doctor/screens/admin/admin_dashboard_page.dart';
import 'package:doctor/screens/dotor_view.dart/home_view.dart';
import 'package:doctor/screens/login.dart';
import 'package:doctor/screens/dashboard_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      title: 'Doctor',
      theme: ThemeData(
        // fontFamily: "Montserrat",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Use StreamBuilder to listen to auth changes
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData) {
            // If the user is logged in, fetch the user's role
            return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(auth.currentUser!.uid)
                  .get(),
              builder: (context, AsyncSnapshot<DocumentSnapshot> roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (roleSnapshot.hasError) {
                  return const Center(child: Text('Error fetching user data'));
                }
                if (!roleSnapshot.hasData || !roleSnapshot.data!.exists) {
                  return const Center(child: Text('User data not found'));
                }
                // Get the user role
                final role = roleSnapshot.data!.get('role');
                if (role == 'admin') {
                  print(role);
                  return const AdminDashboardPage();
                } else if (role == 'user') {
                  print(role);
                  return const DashboardPage();
                } else {
                  print(role);
                  return DoctorHomePage();
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        },
      ),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
    );
  }
}
