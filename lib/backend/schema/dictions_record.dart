import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DictionsRecord extends FirestoreRecord {
  DictionsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "post_photo" field.
  String? _postPhoto;
  String get postPhoto => _postPhoto ?? '';
  bool hasPostPhoto() => _postPhoto != null;

  // "post_title" field.
  String? _postTitle;
  String get postTitle => _postTitle ?? '';
  bool hasPostTitle() => _postTitle != null;

  // "post_description" field.
  String? _postDescription;
  String get postDescription => _postDescription ?? '';
  bool hasPostDescription() => _postDescription != null;

  // "time_posted" field.
  DateTime? _timePosted;
  DateTime? get timePosted => _timePosted;
  bool hasTimePosted() => _timePosted != null;

  // "tag" field.
  String? _tag;
  String get tag => _tag ?? '';
  bool hasTag() => _tag != null;

  void _initializeFields() {
    _postPhoto = snapshotData['post_photo'] as String?;
    _postTitle = snapshotData['post_title'] as String?;
    _postDescription = snapshotData['post_description'] as String?;
    _timePosted = snapshotData['time_posted'] as DateTime?;
    _tag = snapshotData['tag'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('dictions');

  static Stream<DictionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DictionsRecord.fromSnapshot(s));

  static Future<DictionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DictionsRecord.fromSnapshot(s));

  static DictionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DictionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DictionsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DictionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DictionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DictionsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDictionsRecordData({
  String? postPhoto,
  String? postTitle,
  String? postDescription,
  DateTime? timePosted,
  String? tag,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'post_photo': postPhoto,
      'post_title': postTitle,
      'post_description': postDescription,
      'time_posted': timePosted,
      'tag': tag,
    }.withoutNulls,
  );

  return firestoreData;
}

class DictionsRecordDocumentEquality implements Equality<DictionsRecord> {
  const DictionsRecordDocumentEquality();

  @override
  bool equals(DictionsRecord? e1, DictionsRecord? e2) {
    return e1?.postPhoto == e2?.postPhoto &&
        e1?.postTitle == e2?.postTitle &&
        e1?.postDescription == e2?.postDescription &&
        e1?.timePosted == e2?.timePosted &&
        e1?.tag == e2?.tag;
  }

  @override
  int hash(DictionsRecord? e) => const ListEquality().hash(
      [e?.postPhoto, e?.postTitle, e?.postDescription, e?.timePosted, e?.tag]);

  @override
  bool isValidKey(Object? o) => o is DictionsRecord;
}
