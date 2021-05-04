import 'package:authentication_in_flutter/app/app_bloc.dart';
import 'package:authentication_in_flutter/app/modules/auth/login_page.dart';
import 'package:authentication_in_flutter/app/modules/home/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
      ];

  @override
  final List<ModularRoute> routes = [
    // Simple route using the ChildRoute
    ChildRoute('/', child: (_, __) => LoginPage()),
    ChildRoute('/home', child: (_, __) => HomePage()),
  ];
}
