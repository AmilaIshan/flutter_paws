import 'package:flutter/material.dart';
import 'package:paws/components/category.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Home page"),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Catgories', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),)),
              SizedBox(height: 16,),
              Expanded(child: Category())
            ],
          ),
        ),
      ),
    );
  }
}
