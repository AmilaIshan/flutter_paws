import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paws/components/category.dart';
import 'package:paws/components/product.dart';
import 'package:paws/components/shop_details.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../services/auth_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isConnected = false;

  StreamSubscription? _subscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _subscription = InternetConnection().onStatusChange.listen((status) {
      print(status);
      switch(status){
        case InternetStatus.connected:
          setState(() {
            isConnected = true;
          });
          break;
        case InternetStatus.disconnected:
          setState(() {
            isConnected = false;
          });
          break;
        default:
          setState(() {
            isConnected = false;
          });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Welcome ${context.read<AuthService>().userName()}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/banner.png'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: Text(
                      "Welcom to Paws",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Categories",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
              isConnected ? SizedBox(
                height: 160,
                child: Category(),
              ) : Center(
                child: Column(
                  children: [
                    Icon(Icons.wifi_off, size: 50, color: Colors.red,),
                    Text("No Internet Access")
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Recommeded Products",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
              ),
              isConnected ? Product() : Center(
                child: Column(
                  children: [
                    Icon(Icons.wifi_off, size: 50, color: Colors.red,),
                    Text("No Internet Access")
                  ],
                ),
              ),
              Text(
                "Why Choose Us?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ShopDetail(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
