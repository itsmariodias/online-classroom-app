

import 'package:cloud_firestore/cloud_firestore.dart';

class AttachmentsDB {
  CollectionReference attachmentReference = FirebaseFirestore.instance.collection("Attachments");
  CollectionReference attachAnnounceReference = FirebaseFirestore.instance.collection("Attach_Announce");
  CollectionReference attachStudentReference = FirebaseFirestore.instance.collection("Attach_Student");

  AttachmentsDB();

  // function to add Attachments in class in database
  Future<void> createAttachmentsDB(String name, String url, String safeURL, String type) async {
    return await attachmentReference.doc(name+"__"+safeURL).set({
      'name': name,
      'url': url,
      'type': type,
    });
  }

  Future<void> deleteAttachmentsDB(String name, String safeURL) async {
    return await attachmentReference.doc(name+"__"+safeURL).delete();
  }

  // function to add Attachment to Announcement
  Future<void> createAttachAnnounceDB(String title, String url, String safeURL) async {
    return await attachAnnounceReference.doc(title+"__"+safeURL).set({
      'title': title,
      'url': url,
    });
  }

  Future<void> deleteAttachAnnounceDB(String title, String safeURL) async {
    return await attachAnnounceReference.doc(title+"__"+safeURL).delete();
  }


  // function to add Attachment to Student
  Future<void> createAttachmentStudentsDB(String uid, String url, String safeURL, String announcement) async {
    return await attachStudentReference.doc(uid+"__"+safeURL+"__"+announcement).set({
      'uid': uid,
      'url': url,
      'submission' : announcement
    });
  }

  Future<void> deleteAttachmentStudentsDB(String uid, String safeURL, String announcement) async {
    return await attachStudentReference.doc(uid+"__"+safeURL+"__"+announcement).delete();
  }


  // function to make list of Attachments from DB
  Future<List?> createAttachmentsDataList() async {
    return await attachmentReference.get().then(  (ss) => ss.docs.toList()  );
  }

  // function to get list of attach - announce from DB
  Future<List?> createAttachAnnounceList() async {
    return await attachAnnounceReference.get().then(  (ss) => ss.docs.toList()  );
  }

  // function to get list of attach - student from DB
  Future<List?> createAttachmentStudentsList() async {
    return await attachStudentReference.get().then(  (ss) => ss.docs.toList()  );
  }
}