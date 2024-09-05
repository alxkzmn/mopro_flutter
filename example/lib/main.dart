import 'package:flutter/material.dart';
import 'dart:async';

import 'package:mopro_flutter/mopro_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GenerateProofResult? _proofResult;
  final _moproFlutterPlugin = MoproFlutter();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    Map<String, dynamic>? proofResult;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      var inputs = <String, List<String>>{};
      inputs["a"] = ["3"];
      inputs["b"] = ["5"];
      proofResult = await _moproFlutterPlugin.generateProof(
          "assets/multiplier2_final.zkey", inputs);
      print("Proof result: $proofResult");
    } catch (e) {
      print("Error: $e");
      proofResult = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _proofResult = proofResult == null
          ? null
          : GenerateProofResult(proofResult["proof"], proofResult["inputs"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Proof result: $_proofResult\n'),
        ),
      ),
    );
  }
}
