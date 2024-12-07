import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PostsRecord extends FirestoreRecord {
  PostsRecord._(
      DocumentReference reference,
      Map<String, dynamic> data,
      ) : super(reference, data) {
    _initializeFields();
  }

  // "post_title" field.
  String? _postTitle;
  String get postTitle => _postTitle ?? '';
  bool hasPostTitle() => _postTitle != null;

  // "post_description" field.
  String? _postDescription;
  String get postDescription => _postDescription ?? '';
  bool hasPostDescription() => _postDescription != null;

  // "post_user" field.
  DocumentReference? _postUser;
  DocumentReference? get postUser => _postUser;
  bool hasPostUser() => _postUser != null;

  // "time_posted" field.
  DateTime? _timePosted;
  DateTime? get timePosted => _timePosted;
  bool hasTimePosted() => _timePosted != null;

  // "tag" field.
  String? _tag;
  String get tag => _tag ?? '';
  bool hasTag() => _tag != null;

  // "author" field.
  String? _author;
  String get author => _author ?? '';
  bool hasAuthor() => _author != null;

  // "post_photo" field.
  String? _postPhoto;
  String get postPhoto => _postPhoto ?? '';
  bool hasPostPhoto() => _postPhoto != null;

  // "like" field.
  List<DocumentReference>? _like;
  List<DocumentReference> get like => _like ?? const [];
  bool hasLike() => _like != null;

  // "dislike" field.
  List<DocumentReference>? _dislike;
  List<DocumentReference> get dislike => _dislike ?? const [];
  bool hasDislike() => _dislike != null;

  // "post_mutiple_photos" field.
  List<String>? _postMutiplePhotos;
  List<String> get postMutiplePhotos => _postMutiplePhotos ?? const [];
  bool hasPostMutiplePhotos() => _postMutiplePhotos != null;

  // "post_user_photo" field.
  String? _postUserPhoto;
  String get postUserPhoto => _postUserPhoto ?? '';
  bool hasPostUserPhoto() => _postUserPhoto != null;

  void _initializeFields() {
    _postTitle = snapshotData['post_title'] as String?;
    _postDescription = snapshotData['post_description'] as String?;
    _postUser = snapshotData['post_user'] as DocumentReference?;
    _timePosted = snapshotData['time_posted'] as DateTime?;
    _tag = snapshotData['tag'] as String?;
    _author = snapshotData['author'] as String?;
    _postPhoto = snapshotData['post_photo'] as String?;
    _like = getDataList(snapshotData['like']);
    _dislike = getDataList(snapshotData['dislike']);
    _postMutiplePhotos = getDataList(snapshotData['post_mutiple_photos']);
    _postUserPhoto = snapshotData['post_user_photo'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('posts');

  static Stream<PostsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PostsRecord.fromSnapshot(s));

  static Future<PostsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PostsRecord.fromSnapshot(s));

  static PostsRecord fromSnapshot(DocumentSnapshot snapshot) => PostsRecord._(
    snapshot.reference,
    mapFromFirestore(snapshot.data() as Map<String, dynamic>),
  );

  static PostsRecord getDocumentFromData(
      Map<String, dynamic> data,
      DocumentReference reference,
      ) =>
      PostsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PostsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PostsRecord &&
          reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPostsRecordData({
  String? postTitle,
  String? postDescription,
  DocumentReference? postUser,
  DateTime? timePosted,
  String? tag,
  String? author,
  String? postPhoto,
  String? postUserPhoto,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'post_title': postTitle,
      'post_description': postDescription,
      'post_user': postUser,
      'time_posted': timePosted,
      'tag': tag,
      'author': author,
      'post_photo': postPhoto,
      'post_user_photo': postUserPhoto,
    }.withoutNulls,
  );

  return firestoreData;
}

class PostsRecordDocumentEquality implements Equality<PostsRecord> {
  const PostsRecordDocumentEquality();

  @override
  bool equals(PostsRecord? e1, PostsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.postTitle == e2?.postTitle &&
        e1?.postDescription == e2?.postDescription &&
        e1?.postUser == e2?.postUser &&
        e1?.timePosted == e2?.timePosted &&
        e1?.tag == e2?.tag &&
        e1?.author == e2?.author &&
        e1?.postPhoto == e2?.postPhoto &&
        listEquality.equals(e1?.like, e2?.like) &&
        listEquality.equals(e1?.dislike, e2?.dislike) &&
        listEquality.equals(e1?.postMutiplePhotos, e2?.postMutiplePhotos) &&
        e1?.postUserPhoto == e2?.postUserPhoto;
  }

  @override
  int hash(PostsRecord? e) => const ListEquality().hash([
    e?.postTitle,
    e?.postDescription,
    e?.postUser,
    e?.timePosted,
    e?.tag,
    e?.author,
    e?.postPhoto,
    e?.like,
    e?.dislike,
    e?.postMutiplePhotos,
    e?.postUserPhoto
  ]);

  @override
  bool isValidKey(Object? o) => o is PostsRecord;
}
