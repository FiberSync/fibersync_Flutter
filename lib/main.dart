import 'package:fibersync_flutter/pages/WeavingAgent.dart';
import 'package:fibersync_flutter/pages/chatbot.dart';
import 'package:fibersync_flutter/pages/dyeingAgent.dart';
import 'package:fibersync_flutter/pages/home.dart';
import 'package:fibersync_flutter/pages/login.dart';
import 'package:fibersync_flutter/pages/manufacturingAgent.dart';
import 'package:fibersync_flutter/pages/procurementAgent.dart';
import 'package:fibersync_flutter/pages/spinning.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import 'pages/onboard1.dart';


void main() {
  Gemini.init(apiKey: 'AIzaSyCRydem8_aNmql9J2z3ITvY1O6wyxVAtKY');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Change this if using a different base size
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FiberSync',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const OnboardingView(),
           '/login': (context) => LoginPage(),
           '/home': (context) => HomePage(),
           '/procurementAgent': (context) => ProcurementAgentPage(),
           '/spinningAgent': (context) => SpinningAgentPage(),
           '/weavingAgent': (context) => WeavingAgentPage(),
           '/dyeingAgent': (context) => DyeingAgentPage(),
           "/manufacturingAgent": (context) => ManufacturingAgentPage(),
            "/chatbot": (context) => ChatScreen(),
        },
      ),
    );
  }
}
 