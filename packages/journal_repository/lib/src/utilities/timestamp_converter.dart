import 'package:json_annotation/json_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This converter tells json_serializable how to handle DateTime when it encounters
// a Firestore Timestamp in the JSON, and vice-versa.
class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) {
    // Convert Firestore Timestamp to Dart DateTime
    return timestamp.toDate();
  }

  @override
  Timestamp toJson(DateTime date) {
    // Convert Dart DateTime to Firestore Timestamp
    return Timestamp.fromDate(date);
  }
}
