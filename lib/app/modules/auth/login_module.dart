import 'package:authentication_in_flutter/app/modules/auth/login_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginBloc()),
      ];

//  @override
  final List<ModularRoute> routes = [
//       // Simple route using the ChildRoute
//       ChildRoute('/', child: (_, __) => HomePage()),
//       ChildRoute('/login', child: (_, __) => LoginPage()),
  ];
}
