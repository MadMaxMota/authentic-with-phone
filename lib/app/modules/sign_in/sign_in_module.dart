import 'package:authentication_in_flutter/app/modules/sign_in/blocs/phone_number_auth_bloc.dart';
import 'package:authentication_in_flutter/app/modules/sign_in/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'pages/phone_number_page.dart';
import 'services/auth_service.dart';

class SignInModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => AuthService(FirebaseAuth.instance)),
        Bind((i) => PhoneNumberAuthBloc(i.get<AuthService>())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/phone_number_page",
            child: (context, args) => PhoneNumberPage()),
        ChildRoute("/sign_in_page/:numberPhone",
            child: (context, args) => SignInPage(
                  phoneNumber: args.params["numberPhone"],
                )),
      ];
}
