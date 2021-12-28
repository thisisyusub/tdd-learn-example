import 'package:flutter/material.dart';

import 'injection_container.dart' as di;
import 'presentation/app_router.dart';
import 'presentation/pages/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const UsersPage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
