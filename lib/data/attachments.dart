import 'package:flutter/material.dart';

class Attachment {
  String name;
  String url;
  String type;
  IconData icon;
  Color color;

  Attachment({required this.name, required this.url, required this.type, required this.icon, required this.color});
}

Attachment sampleAttachment = Attachment(
    name: "sample.pdf",
    url:"http://www.pdf995.com/samples/pdf.pdf",
    type: "application/pdf",
    icon: Icons.picture_as_pdf,
    color: Colors.red
);