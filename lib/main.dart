import 'package:flutter/material.dart';
import 'package:qube_project/utils/const.dart';
import 'package:qube_project/utils/strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: scaffoldBackgroundColor,
          body: Column(
            children: [
              Container(
                height: searchBarHeight,
                padding: searchBarPadding,
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    label: const Text(searchBarHintText),
                    contentPadding: EdgeInsets.zero,
                    alignLabelWithHint: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(searchBarRadius),
                      borderSide: const BorderSide(color: Colors.white10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
