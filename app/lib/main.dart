import 'package:app/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async
{
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
        name: 'my-app',
        options: DefaultFirebaseOptions.currentPlatform
    );

    runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
    const MyApp({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Jokes app',
            theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                    seedColor: Colors.green
                ),
                useMaterial3: true
            ),
            // home: MyHomePage(),
            home: const LoginPage()
        );
    }

}
