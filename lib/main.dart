import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_ex1/pages/home_page.dart';
import 'package:flutter_firebase_ex1/pages/profile_page.dart';
import 'package:flutter_firebase_ex1/pages/signin_page.dart';
import 'package:flutter_firebase_ex1/pages/signup_page.dart';
import 'package:flutter_firebase_ex1/pages/splash_page.dart';
import 'package:flutter_firebase_ex1/providers/auth/auth_provider.dart';
import 'package:flutter_firebase_ex1/repositories/auth_repository.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (context) => AuthRepository(
              firebaseFirestore: FirebaseFirestore.instance,
              firebaseAuth: fbAuth.FirebaseAuth.instance),
        ),
        StreamProvider<fbAuth.User?>(
            create: (context) => context.read<AuthRepository>().user,
            initialData: null),
        ChangeNotifierProxyProvider<fbAuth.User?, AuthProvider>(
          create: (context) =>
              AuthProvider(authRepository: context.read<AuthRepository>()),
          update: (
            BuildContext context,
            fbAuth.User? userStream,
            AuthProvider? authProvider,
          ) =>
              authProvider!..update(userStream),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const Splashpage(),
        // initialRoute: '/',
        routes: {
          SignInPage.routeName: (context) => SignInPage(),
          SignUpPage.routeName: (context) => SignUpPage(),
          HomePage.routeName: (context) => HomePage(),
        },
      ),
    );
  }
}
