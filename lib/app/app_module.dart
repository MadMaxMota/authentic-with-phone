import 'package:authentication_in_flutter/app/app_bloc.dart';
import 'package:authentication_in_flutter/app/modules/auth/login_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AppBloc()),
      ];

  @override
  final List<ModularRoute> routes = [
    // Simple route using the ChildRoute
    // ChildRoute('/', child: (_, __) => HomePage()),
    // ChildRoute('/login', child: (_, __) => LoginPage()),
  ];
}
