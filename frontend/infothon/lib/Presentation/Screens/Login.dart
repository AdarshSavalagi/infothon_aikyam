import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  Future<void> checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains('name')) {
      Navigator.pushReplacementNamed(context, '/init');
    }
  }

  @override
  void initState() {
    checkSharedPreferences();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  static TextStyle InputTagStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  List _controller = [TextEditingController(), TextEditingController()];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 253, 208),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 150,
                      height: 100,
                      child:
                          Image(image: AssetImage('assets/images/logo.png'))),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelStyle: InputTagStyle,
                    labelText: "Enter Name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  controller: _controller[0],
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Name cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _controller[1],
                  decoration: InputDecoration(
                    labelStyle: InputTagStyle,
                    labelText: "Enter email",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "email cannot be empty";
                    } else if (val.length > 15 || val.length < 6) {
                      return "Invalid email Format";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom + 16),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      var preferences = await SharedPreferences.getInstance();
                      await preferences.setString('name', _controller[0].text);
                      await preferences.setString('email', _controller[1].text);
                      await preferences.setInt('gender', _selected);
                     
                      Navigator.pushNamed(context, '/init');
                    }
                  },
                  child: Container(
                    height: 58,
                    padding: const EdgeInsets.only(
                      left: 56.0,
                      right: 56.0,
                      top: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(38.0),
                      color: const Color(0xff132137),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
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

  Widget _icon(int index, {required String text}) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 16, bottom: 16),
      child: InkResponse(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color:
                            _selected == index ? Colors.red : Colors.black54),
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text,
                      style: TextStyle(
                          color: _selected == index ? Colors.red : null)),
                )),
          ],
        ),
        onTap: () => setState(
          () {
            _selected = index;
          },
        ),
      ),
    );
  }
}
