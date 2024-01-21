import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../data/constants.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  static TextStyle InputTagStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  bool _isButtonDisabled = false;
  List _controller = List.generate(5, (index) => TextEditingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FeedbackPage")),
      body: Form(
          key: _formKey,
          child: ListView(children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Thanks for your FeedbackPage! It helps us improve our services. Remember, if you need help now, Please feel free to call us",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _controller[0],
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "Enter Name",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
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
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _controller[2],
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "Enter Phone",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Phone cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.phone,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _controller[3],
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "subject",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "subject cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _controller[4],
                maxLines: 3,
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "Enter Message",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Message cannot be empty";
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.multiline,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: _isButtonDisabled
                    ? null
                    : () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          setState(() {
                            _isButtonDisabled = true;
                          });

                          Map<String, dynamic> data = {
                            'name': _controller[0].text,
                            'mail': _controller[1].text,
                            'message': _controller[4].text,
                            'phone': _controller[2].text,
                            'subject': _controller[3].text,
                            'type': "1"
                          };

                          try {
                            final response =
                                await http.post(Uri.parse(apiUrl), body: data);
                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Your response was saved successfully'),
                                ),
                              );
                            } else {
                              print(response.body);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'There was an error while saving your data'),
                                ),
                              );
                            }
                          } catch (error) {
                            print('Error: $error');
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('An unexpected error occurred'),
                              ),
                            );
                          } finally {
                            setState(() {
                              _isButtonDisabled = false;
                            });
                          }
                        }
                      },
                child: const Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "In order to understand your FeedbackPage, we may recieve diagnostic information from your device. While we cannot reply to FeedbackPage, all comments are taken into consideraton",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            )
          ])),
    );
  }
}
