import "package:flutter/material.dart";

InputDecoration kInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}

//for showdialogue. takes in 3 arguments, context and 2 string
Future<void> showDialogue(
    BuildContext context, String title, String buttonText) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        actions: <Widget>[
          ElevatedButton(
            child: Text(buttonText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

const kTitleStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);

const kSizedBoxSmall = SizedBox(
  height: 10,
);

const kSizedBoxMedium = SizedBox(
  height: 20,
);

const kSizedBoxLarge = SizedBox(
  height: 30,
);

const kPadding = EdgeInsets.all(14);
