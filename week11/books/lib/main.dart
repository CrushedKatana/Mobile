import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'geolocation.dart';
import 'navigation_first.dart';
import 'navigation_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Back from the Future - Charel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const NavigationDialogScreen(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';
  late Completer completer;

  Future<Response> getData() async {
    const authority = 'www.googleapis.com';
    const path = '/books/v1/volumes/TBnWDwAAQBAJ';
    Uri url = Uri.https(authority, path);
    return http.get(url);
  }

  Future<int> returnOneAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 1;
  }

  Future<int> returnTwoAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 2;
  }

  Future<int> returnThreeAsync() async {
    await Future.delayed(const Duration(seconds: 3));
    return 3;
  }

  Future count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  Future getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  }

  // Praktikum 4: FutureGroup
  void returnFG() {
    FutureGroup<int> futureGroup = FutureGroup<int>();
    futureGroup.add(returnOneAsync());
    futureGroup.add(returnTwoAsync());
    futureGroup.add(returnThreeAsync());
    futureGroup.close();
    futureGroup.future.then((List<int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
  }

  // Praktikum 4: Future.wait
  Future returnFW() async {
    final futures = Future.wait<int>([
      returnOneAsync(),
      returnTwoAsync(),
      returnThreeAsync(),
    ]);
    
    futures.then((List<int> value) {
      int total = 0;
      for (var element in value) {
        total += element;
      }
      setState(() {
        result = total.toString();
      });
    });
  }

  // Praktikum 5: Error Handling with then/catchError
  Future returnError() async {
    await Future.delayed(const Duration(seconds: 2));
    throw Exception('Something terrible happened!');
  }

  // Praktikum 5: Error Handling with try-catch
  Future handleError() async {
    try {
      await returnError();
    } catch (error) {
      setState(() {
        result = error.toString();
      });
    } finally {
      print('Complete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future - Charel'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            // Praktikum 1: Soal 3
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 3: getData()'),
              onPressed: () {
                setState(() {
                  result = 'Loading...';
                });
                getData().then((value) {
                  setState(() {
                    result = value.body.toString().substring(0, 450);
                  });
                }).catchError((_) {
                  setState(() {
                    result = 'An error occurred';
                  });
                });
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 2: Soal 4
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 4: count()'),
              onPressed: () {
                setState(() {
                  result = 'Counting...';
                });
                count();
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 3: Soal 5
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 5: getNumber()'),
              onPressed: () {
                setState(() {
                  result = 'Calculating...';
                });
                getNumber().then((value) {
                  setState(() {
                    result = value.toString();
                  });
                });
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 3: Soal 6
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 6: getNumber() + Error'),
              onPressed: () {
                setState(() {
                  result = 'Processing...';
                });
                getNumber().then((value) {
                  setState(() {
                    result = value.toString();
                  });
                }).catchError((e) {
                  setState(() {
                    result = 'An error occurred';
                  });
                });
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 4: Soal 7
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 7: FutureGroup'),
              onPressed: () {
                setState(() {
                  result = 'Running parallel...';
                });
                returnFG();
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 4: Soal 8
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 8: Future.wait'),
              onPressed: () {
                setState(() {
                  result = 'Running parallel...';
                });
                returnFW();
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 5: Soal 9
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 9: returnError()'),
              onPressed: () {
                setState(() {
                  result = 'Waiting for error...';
                });
                returnError().then((value) {
                  setState(() {
                    result = 'Success';
                  });
                }).catchError((onError) {
                  setState(() {
                    result = onError.toString();
                  });
                }).whenComplete(() => print('Complete'));
              },
            ),
            const SizedBox(height: 10),
            // Praktikum 5: Soal 10
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                foregroundColor: Colors.black,
                minimumSize: const Size(200, 50),
              ),
              child: const Text('Soal 10: handleError()'),
              onPressed: () {
                setState(() {
                  result = 'Handling error...';
                });
                handleError();
              },
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minHeight: 100,
                maxWidth: 350,
              ),
              child: SingleChildScrollView(
                child: Text(
                  result.isEmpty ? 'Tekan salah satu tombol untuk memulai' : result,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Spacer(),
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
