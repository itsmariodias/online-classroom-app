import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SubmissionComposer extends StatefulWidget {
  Color uiColor;

  SubmissionComposer(this.uiColor);

  @override
  _SubmissionComposerState createState() => _SubmissionComposerState();
}

class _SubmissionComposerState extends State<SubmissionComposer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: MaterialButton(
          height: 50.0,
          minWidth: double.infinity,
          color: widget.uiColor,
          textColor: Colors.white,
          child: Text("Submit",
                  style: TextStyle(fontSize: 20, letterSpacing: 1, fontWeight: FontWeight.bold)),
          onPressed: () => {},
        ))
      ],
    );
  }
}
