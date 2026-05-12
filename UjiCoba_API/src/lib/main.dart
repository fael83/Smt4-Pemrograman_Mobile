import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uji_coba_api/firebase_options.dart'; 
import 'package:uji_coba_api/profile_screen.dart';
import 'package:uji_coba_api/weather_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // fix: tambahkan DefaultFirebaseOptions
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<FirebaseApp>(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
            return LoginScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // fix: pindahkan controller ke sini, bukan di dalam build()
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // fix: tambahkan dispose() untuk mencegah memory leak
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Login function
  static Future<User?> loginUsingEmailPassword(
    {required String email,
     required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      // fix: tambahkan lebih banyak error handling
      if (e.code == "user-not-found") {
        debugPrint("No user found for that email");
      } else if (e.code == "wrong-password") {
        debugPrint("Wrong password provided");
      } else {
        debugPrint("FirebaseAuthException: ${e.code}");
      }
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "MyApp Title",
            style: TextStyle(
              color: Colors.black,
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              ),
            ),
          const Text(
            "Login to Your App",
              style: TextStyle(
                color: Colors.black,
                fontSize: 44.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          const SizedBox(
            height: 44.0,
            ),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: "User Email",
              prefixIcon: Icon(Icons.email, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 26.0,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: "User Password",
              prefixIcon: Icon(Icons.lock, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 12
            ),
          const Text( // fix: tambahkan const
            "Don't Remember your Password?",
            style: TextStyle(color: Colors.blue),
          ),
          const SizedBox(
            height: 88.0,
          ),
          Container(
            width: double.infinity,
            child: RawMaterialButton(
              fillColor: const Color(0xFF0069FE),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),),
              onPressed: () async {
                User? user = await loginUsingEmailPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                  context: context,
                );
                debugPrint(user.toString()); 
                if (user != null) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => WeatherScreen()),
                  );
                }
              },
              child: const Text("Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
              )),
            ),
          ),
        ],
      ),
    );
  }
}