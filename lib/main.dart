import 'package:flutter/material.dart';
import 'package:instagram_clone/ui/screens/home_page.dart';
import 'package:instagram_clone/ui/helpers/responsive_service.dart'; // 👈 ekledik

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            final mediaQuery = MediaQuery.of(context);

            // ekran boyutlarını singleton’a kaydet
            final responsive = ResponsiveService();
            responsive.screenWidth = mediaQuery.size.width;
            responsive.screenHeight = mediaQuery.size.height;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
                useMaterial3: true,
              ),
              home: const HomePage(),
            );
          },
        );
      },
    );
  }
}
