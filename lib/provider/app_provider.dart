import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  AppProvider() {
    initializeApp();
  }

  bool? isInitialized;

  Future initializeApp() async {
    try {
      await Firebase.initializeApp();
      Function? originalOnError = FlutterError.onError;
      FlutterError.onError = (FlutterErrorDetails errorDetails) async {
        originalOnError!(errorDetails);
      };
      isInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      debugPrint("isAppInitialized: $isInitialized");
    }
  }
}
