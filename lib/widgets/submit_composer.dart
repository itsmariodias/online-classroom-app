import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:online_classroom/data/accounts.dart';
import 'package:online_classroom/data/announcements.dart';
import 'package:online_classroom/data/attachments.dart';
import 'package:online_classroom/data/custom_user.dart';
import 'package:online_classroom/data/submissions.dart';
import 'package:online_classroom/services/attachments_db.dart';
import 'package:online_classroom/services/submissions_db.dart';
import 'package:online_classroom/services/updatealldata.dart';
import 'package:online_classroom/widgets/attachment_editor_composer.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

class SubmissionComposer extends StatefulWidget {
  Announcement assignment;
  Color uiColor;

  SubmissionComposer(this.assignment, this.uiColor);

  @override
  _SubmissionComposerState createState() => _SubmissionComposerState();
}

class _SubmissionComposerState extends State<SubmissionComposer> {

  List attachments = [];
  bool firstTime = true;

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  Future addFile(String user, String className) async {
    File? file;
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    file = File(path);

    final fileName = basename(file.path);
    final destination = user+"/"+className+'/$fileName';

    UploadTask? task = uploadFile(destination, file);

    if (task == null) return;

    final snapshot = await task.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    String safeURL = urlDownload.replaceAll(new RegExp(r'[^\w\s]+'),'');
    await AttachmentsDB().createAttachmentsDB(fileName, urlDownload, safeURL, lookupMimeType(fileName) as String);

    setState(() => attachments.add(Attachment(name: fileName, url: urlDownload,
        type: lookupMimeType(fileName) as String
    )));
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);
    var account = getAccount(user!.uid);

    print(submissionList);
    Submission userSubmission = submissionList.firstWhere((i) => i.assignment.title == widget.assignment.title && i.user.uid == user.uid && i.classroom.className == widget.assignment.classroom.className);

    print("Reloaded");
    if(firstTime) {
      attachments = userSubmission.attachments;
      firstTime = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: MediaQuery.of(context).size.width,
          height: 2,
          color: widget.uiColor,
        ),
        Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              "Your Work",
              style: TextStyle(
                  fontSize: 15, color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold
              ),
            )
        ),
        if(attachments.length > 0) Padding(
            padding: EdgeInsets.all(20),
            child: AttachmentEditorComposer(attachmentList: attachments, isTeacher: false, title: widget.assignment.title, className: widget.assignment.classroom.className)
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: OutlinedButton(
                onPressed: () {
                  addFile(account!.email as String, widget.assignment.classroom.className);
                  setState(() => {});
                },
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Add Attachment",
                              style: TextStyle(color: Colors.black87, fontSize: 14)),
                          Icon(
                            Icons.add_circle_outline_outlined,
                            color: widget.assignment.classroom.uiColor,
                            size: 32,
                          )
                        ]
                    )
                )
            ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: MaterialButton(
            enableFeedback: false,
            height: 50.0,
            minWidth: double.infinity,
            color: widget.uiColor,
            textColor: Colors.white,
            child: Text(
                "Submit",
                style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold
                )
            ),
            onPressed: () async {

              for(int i=0; i<attachments.length; i++) {
                String safeURL = attachments[i].url.replaceAll(new RegExp(r'[^\w\s]+'),'');

                await AttachmentsDB().createAttachmentStudentsDB(user.uid, attachments[i].url, safeURL, widget.assignment.classroom.className+"__"+widget.assignment.title);
              }

              await SubmissionDB().updateSubmissions(user.uid, widget.assignment.classroom.className, widget.assignment.title, true);

              final snackBar = SnackBar(
                content: const Text('Submitted'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () async {
                    await SubmissionDB().updateSubmissions(user.uid, widget.assignment.classroom.className, widget.assignment.classroom.className+"__"+widget.assignment.title, false);
                    await updateAllData();
                  },
                ),
              );

              // Find the ScaffoldMessenger in the widget tree
              // and use it to show a SnackBar.
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              await updateAllData();
            },
          )
        )
      ],
    );
  }
}
