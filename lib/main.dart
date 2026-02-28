// import 'package:aplicacionflutter/config/router/app_router.dart';
// import 'package:aplicacionflutter/config/theme/app_theme.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// Future<void> main() async {
//   await dotenv.load(fileName: '.env');
//   runApp(const ProviderScope(child: MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: appRouter,
//       debugShowCheckedModeBanner: false,
//       theme: appTheme().getTheme(),
//       title: 'Material App',
//       // home: Scaffold(
//       //   appBar: AppBar(title: const Text('Material App Bar')),
//       //   body: const Center(child: Text('Hello World')),
//       // ),
//     );
//   }
// }
import 'package:aplicacionflutter/modulo/pages/view_flow_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewFlowsPage(),
    );
  }
}
