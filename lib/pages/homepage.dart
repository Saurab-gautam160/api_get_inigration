import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<dynamic> getRequest() async {
    try {
      final response = await http.get(Uri.parse('https://api.kanye.rest/'));
      final res = jsonDecode(response.body);
      return (res['quote']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getRequest();
    return Scaffold(
      appBar: AppBar(
        title: const Text('API '),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          FutureBuilder(
            future: getRequest(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                // Use the snapshot data to build your UI
                final data = snapshot.data;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          ' $data',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              final data = snapshot.data;
                            });
                          },
                          icon: const Icon(Icons.refresh_rounded),
                          label: const Text('Refresh button'),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
