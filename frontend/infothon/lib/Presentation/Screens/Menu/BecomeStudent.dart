import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/constants.dart';


class BecomeStudent extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<BecomeStudent> {
  final _formKey = GlobalKey<FormState>();
  List _controller = List.generate(4, (index) => TextEditingController());
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var item in jsonDecode(prefs.getString('department') ?? '')) {
      if (item['isUg']) {
        branches[0].add(item['name']);
      } else {
        branches[1].add(item['name']);
      }
    }
  }

  List<List<String>> branches = [
    ['select Course'],
    ['select Course']
  ];
  bool _isButtonDisabled = false;

  // dynamic countries=UG;
  late String? select = 'select Course';

  static TextStyle InputTagStyle =
      const TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Student'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Text(
                "Admission Enquiry",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: _controller[0],
                decoration: InputDecoration(
                  labelText: "Enter Name",
                  fillColor: Colors.white,
                  labelStyle: InputTagStyle,
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
                keyboardType: TextInputType.emailAddress,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller[1],
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "Enter Email",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  //fillColor: Colors.green
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
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller[2],
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "Enter Phone number",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  //fillColor: Colors.green
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
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _controller[3],
                decoration: InputDecoration(
                  labelStyle: InputTagStyle,
                  labelText: "Enter City",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    gapPadding: 2,
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(width: 5),
                  ),
                  //fillColor: Colors.green
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
              Row(
                children: [
                  _icon(0, text: "UG"),
                  _icon(1, text: "PG"),
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  //background color of dropdown button
                  border: Border.all(
                      color: Colors.black38,
                      width: 3), //border of dropdown button
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                  child: DropdownButton(
                    icon: const Icon(Icons.arrow_drop_down),
                    // Custom dropdown icon
                    iconSize: 24,
                    // Adjust icon size if needed
                    iconEnabledColor: Colors.grey,
                    // Adjust icon color if needed
                    isExpanded: true,
                    // Expand the dropdown button to fill available horizontal space
                    underline: Container(),

                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Theme.of(context).textTheme.bodyMedium?.color),
                    borderRadius: BorderRadius.circular(20.0),

                    value: select,
                    items: branches[_selected].map((country) {
                      return DropdownMenuItem(
                          value: country,
                          child: SizedBox(
                              height: 18,
                              child: Text(
                                country,
                                maxLines: 2,
                              )));
                    }).toList(),
                    onChanged: (country) {
                      setState(() {
                        select = country;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
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
                            'phone': _controller[2].text,
                            'city': _controller[3].text,
                            'course': select,
                            'type': '2',
                          };

                          try {
                            final response =
                                await http.post(Uri.parse(apiUrl), body: data);

                            if (response.statusCode == 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Your data was saved successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'There was an error while saving your data'),
                                ),
                              );
                            }
                          } catch (error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('An unexpected error occurred'),
                              ),
                            );
                          }
                          setState(() {
                            _isButtonDisabled = false;
                          });
                        }
                      },
                child: const Text(
                  'Submit',
                ),
              ),
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
            select = branches[0][0];
            // countries = index == 0 ? UG:PG;
          },
        ),
      ),
    );
  }
}
