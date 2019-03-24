import 'package:fl_uberapp/src/blocs/auth_bloc.dart';
import 'package:flutter/material.dart';

class MyApp extends InheritedWidget {
  final AuthBloc authBloc;
  MyApp(this.authBloc, Widget child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static MyApp of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyApp);
  }
}
