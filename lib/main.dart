import 'package:flutter/material.dart';
import 'Models/Tenant.dart';
// import 'package:intl/intl.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firestore',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _user = Tenant();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextFormField('First name', 'Please enter the tenant\'s  first name'),
              TextFormField(
                decoration: InputDecoration(labelText: 'Last name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the tenant\'s last name';
                  }
                  return null;
                },
                onSaved: (val) => setState(() => _user.lastName = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Make / Model'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the tenant\'s make and model';
                  }
                  return null;
                },
                onSaved: (val) => setState(() => _user.makeModel = val),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'License Plate'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the tenant\'s license plate';
                  }
                  return null;
                },
                onSaved: (val) => setState(() => _user.licensePlate = val),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: RaisedButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    if (form.validate()) {
                      form.save();
                      _user.save();
                      _showDialog(context);
                    }
                  },
                  child: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField buildTextFormField(String labelText, String emptySign) {
    return TextFormField(
              decoration: InputDecoration(labelText: labelText),
              validator: (value) {
                if (value.isEmpty) {
                  return emptySign;
                }
                _user.firstName = value;
                return null;
              },
              onSaved: (val) => setState(() => _user.firstName = val),
            );
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Submitting form'),
      ),
    );
  }
}

// class BasicDateField extends StatelessWidget {
//   final format = DateFormat("yyyy-MM-dd");
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: <Widget>[
//       Text('Basic date field (${format.pattern})'),
//       DateTimeField(
//         format: format,
//         onShowPicker: (context, currentValue) {
//           return showDatePicker(
//               context: context,
//               firstDate: DateTime(1900),
//               initialDate: currentValue ?? DateTime.now(),
//               lastDate: DateTime(2100));
//         },
//       ),
//     ]);
//   }
// }
