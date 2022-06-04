import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lovely_money/models/login.dart';
import 'package:lovely_money/screens/login_screen.dart';
import 'package:lovely_money/screens/dashboard_screen.dart';
import 'package:lovely_money/screens/register_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: "config.env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: dotenv.get('apiKey'),
        authDomain: dotenv.get('authDomain'),
        projectId: dotenv.get('projectId'),
        storageBucket: dotenv.get('storageBucket'),
        messagingSenderId: dotenv.get('messagingSenderId'),
        appId: dotenv.get('appId'),
        measurementId: dotenv.get('measurementId')),
  );

  runApp(LovelyMoney());
}

class LovelyMoney extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return material app with multi provider
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Login(),
        ),
      ],
      child: MaterialApp(
        title: 'Lovely Money',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // initialRoute: LoginScreen.id,
        initialRoute: DashboardScreen.id,
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          RegisterScreen.id: (context) => RegisterScreen(),
          DashboardScreen.id: (context) => DashboardScreen(),
        },
      ),
    );
  }
}
