import 'package:authentication_in_flutter/app/modules/sign_in/sign_in_module.dart';
import 'package:authentication_in_flutter/app/modules/sucess/sucess_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    // Simple route using the ChildRoute
    ModuleRoute('/', module: SignInModule()),
    ModuleRoute('/home', module: SucessModule()),
  ];
}
