import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/data/custom_user.dart';
import 'package:online_classroom/services/attachments_db.dart';
import 'package:online_classroom/services/submissions_db.dart';
import 'package:online_classroom/services/updatealldata.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher.dart';

void _launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';


class AttachmentEditorComposer extends StatefulWidget {
  List attachmentList;
  String title = "";
  bool isTeacher = true;
  String className;

  AttachmentEditorComposer({required this.attachmentList, this.title = "", this.isTeacher = true, this.className = ""});

  @override
  _AttachmentEditorComposerState createState() => _AttachmentEditorComposerState();
}

class _AttachmentEditorComposerState extends State<AttachmentEditorComposer> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    return Container(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: widget.attachmentList.length,
            itemBuilder: (context, int index) {
              return InkWell(
                  onTap: () {
                    _launchURL(widget.attachmentList[index].url);
                    // OpenFile.open(widget.attachmentList[index].url);
                  },
                  child: Container(
                      margin: EdgeInsets.only(
                          bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(color: Colors.black87, blurRadius: 0.05)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30)),
                                    child: Icon(
                                      Icons.picture_as_pdf,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.attachmentList[index].name,
                                        style: TextStyle(fontSize: 15, letterSpacing: 1),
                                      ),
                                    ],
                                  )]
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30)),
                                child: IconButton (
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  onPressed: () async {
                                    String safeURL = widget.attachmentList[index].url.replaceAll(new RegExp(r'[^\w\s]+'),'');
                                    await AttachmentsDB().deleteAttachmentsDB(widget.attachmentList[index].name, safeURL);

                                    print("Deleted attachment");

                                    if(widget.title != "" && widget.isTeacher) {
                                      await AttachmentsDB().deleteAttachAnnounceDB(widget.title, safeURL);
                                      print("Deleted reference to attachment on announcement");
                                    }
                                    else {
                                      await AttachmentsDB().deleteAttachmentStudentsDB(user!.uid, safeURL, widget.className+"__"+widget.title);
                                      await SubmissionDB().updateSubmissions(user.uid, widget.className, widget.title, false);
                                      print("Deleted reference to attachment on announcement");
                                    }
                                    setState(() => {widget.attachmentList.removeAt(index)});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                  ));
            })
    );
  }
}
