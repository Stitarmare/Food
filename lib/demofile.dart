import 'package:flutter/material.dart';

class DropdownFormField<T> extends FormField<T> {
  DropdownFormField({
    Key key,
    InputDecoration decoration,
    T initialValue,
    List<DropdownMenuItem<T>> items,
    bool autovalidate = false,
    FormFieldSetter<T> onSaved,
    FormFieldValidator<T> validator,
  }) : super(
          key: key,
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          initialValue: items.contains(initialValue) ? initialValue : null,
          builder: (FormFieldState<T> field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                  errorText: field.hasError ? field.errorText : null),
              isEmpty: field.value == '' || field.value == null,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<T>(
                  value: field.value,
                  isDense: true,
                  onChanged: field.didChange,
                  items: items.toList(),
                ),
              ),
            );
          },
        );
}

// import 'package:flutter/material.dart';

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   static List<CountryModel> _dropdownItems = new List();
//   final formKey = new GlobalKey<FormState>();

//   CountryModel _dropdownValue;
//   String _errorText;

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       _dropdownItems.add(CountryModel(country: 'India', countryCode: '+91'));
//       _dropdownItems.add(CountryModel(country: 'USA', countryCode: '+1'));
//       _dropdownValue = _dropdownItems[0];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text('Demo'),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             _buildCountry(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCountry() {
//     return FormField(
//       builder: (FormFieldState state) {
//         return DropdownButtonHideUnderline(

//           child: new Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               new InputDecorator(
//                 decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(5.0)),
//                   filled: false,
//                   hintText: 'Choose Country',
//                   prefixIcon: Icon(Icons.location_on),
//                   labelText:
//                       _dropdownValue == null ? 'Where are you from' : 'From',
//                   errorText: _errorText,
//                 ),
//                 isEmpty: _dropdownValue == null,
//                 child: new DropdownButton<CountryModel>(
//                   value: _dropdownValue,
//                   isDense: true,
//                   onChanged: (CountryModel newValue) {
//                     print('value change');
//                     print(newValue);
//                     setState(() {
//                       _dropdownValue = newValue;
//                     });
//                   },
//                   items: _dropdownItems.map((CountryModel value) {
//                     return DropdownMenuItem<CountryModel>(
//                       value: value,
//                       child: Text(value.country),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// class CountryModel {
//   String country = '';
//   String countryCode = '';

//   CountryModel({
//     this.country,
//     this.countryCode,
//   });
// }
