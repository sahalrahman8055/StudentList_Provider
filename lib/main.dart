import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/add_provider.dart';
import 'package:student_app/controller/edit_Provider.dart';
import 'package:student_app/controller/db_functions_provider.dart';
import 'package:student_app/helper/colors.dart';
import 'package:student_app/model/data_model.dart';
import 'package:student_app/view/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddProvider()),
        ChangeNotifierProvider(create: (context) => EditProvider()),
        ChangeNotifierProvider(create: (context) => StudentDbProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Students List',
        theme: ThemeData(primarySwatch: kGreen),
        home: const Scaffold(
          body: ScreenSplash(),
        ),
      ),
    );
  }
}
