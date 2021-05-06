import 'package:authentication_in_flutter/app/modules/sign_in/blocs/phone_number_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SignInPage extends StatefulWidget {
  final String phoneNumber;

  const SignInPage({
    Key key,
    @required this.phoneNumber,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _phoneNumberAuthBloc = Modular.get<PhoneNumberAuthBloc>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _phoneNumberAuthBloc.add(
      PhoneNumberAuthEvent.sendCodePressed(widget.phoneNumber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 70, 30),
                child: Text(
                  'Confirme seu número',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "Digite o código de 4 dígitos enviado ao número de celular  ${widget.phoneNumber}:",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                maxLength: 6,
                maxLengthEnforced: true,
                cursorColor: Colors.grey,
                onSubmitted: (value) {
                  if (value.length == 6) {
                    _phoneNumberAuthBloc.add(
                      PhoneNumberAuthEvent.checkSentCodePressed(value),
                    );
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Informe o código OTP',
                  hintStyle: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 145),
                child: TextButton(
                  child: Text(
                    "Reenviar código por SMS",
                    style: TextStyle(color: Color(0xff008C8C)),
                  ),
                  onPressed: () {
                    _phoneNumberAuthBloc.add(
                      PhoneNumberAuthEvent.sendCodePressed(widget.phoneNumber),
                    );
                  },
                ),
              ),
              const SizedBox(height: 120),
              Container(
                width: 300,
                height: 50,
                color: Color(0xff008C8C),
                child: ElevatedButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xff008C8C)),
                  onPressed: () {},
                  child: Text(
                    'Avançar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              BlocConsumer<PhoneNumberAuthBloc, PhoneNumberAuthState>(
                bloc: _phoneNumberAuthBloc,
                listener: (context, state) {
                  state.map(
                    initial: (event) {
                      _phoneNumberAuthBloc.add(
                        PhoneNumberAuthEvent.sendCodePressed(
                            widget.phoneNumber),
                      );
                    },
                    loading: (event) {},
                    loadedWithFailure: (event) {
                      String message;
                      message = event.failure.map<String>(
                        serverError: (failure) =>
                            "Authentication error, try later!",
                        wrongSentCode: (failure) => "Wrong sent code",
                        manyRequests: (failure) =>
                            "you made too many requests, try later!",
                        sessionExpired: (failure) {
                          _phoneNumberAuthBloc.add(
                            PhoneNumberAuthEvent.sendCodePressed(
                              widget.phoneNumber,
                            ),
                          );
                          return "You missed the code several times, wait for a new one!";
                        },
                      );
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            message,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    loadedWithSucess: (event) async {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Sucess!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                      await Future.delayed(const Duration(seconds: 2));
                      Modular.to.pushReplacementNamed("/sucess");
                    },
                  );
                },
                builder: (context, state) {
                  return state is Loading
                      ? CircularProgressIndicator()
                      : Container();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
