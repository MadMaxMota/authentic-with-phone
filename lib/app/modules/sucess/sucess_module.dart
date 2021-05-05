import 'package:authentication_in_flutter/app/modules/sucess/pages/sucess_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SucessModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routers => [
        ChildRoute("/sucess_page", child: (context, args) => SucessPage()),
      ];
}
