import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommentsRecord extends FirestoreRecord {
  CommentsRecord._(
      DocumentReference reference,
      Map<String, dynamic> data,
      ) : super(reference, data) {
    _initializeFields();
  }

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  bool hasComment() => _comment != null;

  // "comment_name" field.
  String? _commentName;
  String get commentName => _commentName ?? '';
  bool hasCommentName() => _commentName != null;

  // "comment_post" field.
  DocumentReference? _commentPost;
  DocumentReference? get commentPost => _commentPost;
  bool hasCommentPost() => _commentPost != null;

  // "comment_user" field.
  DocumentReference? _commentUser;
  DocumentReference? get commentUser => _commentUser;
  bool hasCommentUser() => _commentUser != null;

  // "comment_photo" field.
  String? _commentPhoto;
  String get commentPhoto => _commentPhoto ?? '';
  bool hasCommentPhoto() => _commentPhoto != null;

  void _initializeFields() {
    _createdAt = snapshotData['created_at'] as DateTime?;
    _comment = snapshotData['comment'] as String?;
    _commentName = snapshotData['comment_name'] as String?;
    _commentPost = snapshotData['comment_post'] as DocumentReference?;
    _commentUser = snapshotData['comment_user'] as DocumentReference?;
    _commentPhoto = snapshotData['comment_photo'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('comments');

  static Stream<CommentsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommentsRecord.fromSnapshot(s));

  static Future<CommentsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommentsRecord.fromSnapshot(s));

  static CommentsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommentsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommentsRecord getDocumentFromData(
      Map<String, dynamic> data,
      DocumentReference reference,
      ) =>
      CommentsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommentsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommentsRecord &&
          reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommentsRecordData({
  DateTime? createdAt,
  String? comment,
  String? commentName,
  DocumentReference? commentPost,
  DocumentReference? commentUser,
  String? commentPhoto,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'created_at': createdAt,
      'comment': comment,
      'comment_name': commentName,
      'comment_post': commentPost,
      'comment_user': commentUser,
      'comment_photo': commentPhoto,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommentsRecordDocumentEquality implements Equality<CommentsRecord> {
  const CommentsRecordDocumentEquality();

  @override
  bool equals(CommentsRecord? e1, CommentsRecord? e2) {
    return e1?.createdAt == e2?.createdAt &&
        e1?.comment == e2?.comment &&
        e1?.commentName == e2?.commentName &&
        e1?.commentPost == e2?.commentPost &&
        e1?.commentUser == e2?.commentUser &&
        e1?.commentPhoto == e2?.commentPhoto;
  }

  @override
  int hash(CommentsRecord? e) => const ListEquality().hash([
    e?.createdAt,
    e?.comment,
    e?.commentName,
    e?.commentPost,
    e?.commentUser,
    e?.commentPhoto
  ]);

  @override
  bool isValidKey(Object? o) => o is CommentsRecord;
}
