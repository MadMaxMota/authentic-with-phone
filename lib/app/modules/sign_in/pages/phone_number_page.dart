import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PhoneNumberPage extends StatelessWidget {
  final _phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Number phone page"),
      //   backgroundColor: Colors.red,
      // ),
      // backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 30, 5, 30),
                child: Text(
                  'Entre ou cadastre-se na Growp',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 58,
                    color: Colors.grey[300],
                    child: Center(
                      child: Text(
                        '+55',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.grey,
                      controller: _phoneNumberController,
                      onSubmitted: (value) {
                        if (value.length == 14) {
                          Modular.to.pushNamed("/sign_in_page/$value");
                        }
                      },
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "(00) 0 0000-0000",
                        hintStyle: TextStyle(
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 20),
                child: Text(
                  'Ao continuar, você pode receber um SMS para confirmação. Pode haver cobranças de taxas de envio de mensagens de dados.',
                  style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 150),
              Container(
                width: 280,
                height: 50,
                color: Color(0xff008C8C),
                child: ElevatedButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0xff008C8C)),
                  onPressed: () {},
                  child: Text(
                    'Continuar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
