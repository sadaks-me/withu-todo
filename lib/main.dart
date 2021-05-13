import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:withu_todo/view/pages/home_page.dart';
import 'package:withu_todo/view/widgets/loader_widget.dart';

import 'provider/app_provider.dart';
import 'provider/todo_provider.dart';
import 'util.dart';
import 'view/widgets/error_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;

  runZonedGuarded(() {
    runApp(WithUTodoApp());
  }, (error, stackTrace) {
    debugPrint('runZonedGuarded: Caught error in my root zone.\n$stackTrace');
  });
}

class WithUTodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppProvider()),
          ChangeNotifierProvider(create: (_) => TodoProvider()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          enableLog: false,
          title: title,
          theme: appTheme,
          builder: (context, child) => Consumer<AppProvider>(
            builder: (context, appProvider, child) {
              if (appProvider.isInitialized != null) {
                if (appProvider.isInitialized!)
                  return child!;
                else
                  return ErrorScreen(
                    message: "Problem initialising the app",
                    buttonTitle: "RETRY",
                    onTap: appProvider.initializeApp,
                  );
              }
              return LoaderWidget();
            },
            child: child,
          ),
          home: HomePage(),
        ));
  }
}
