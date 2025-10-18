import 'package:flutter/material.dart';

class Note {
  final int? id;
  final String title;
  final String content;
  final Color color;
  final DateTime dateTime;

  const Note({
    this.id,
    required this.title,
    required this.content,
    required this.color,
    required this.dateTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color.toARGB32().toString(),
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as int?,
      title: map['title'] as String,
      content: map['content'] as String,
      color: Color(int.parse(map['color'] as String)),
      dateTime: DateTime.parse(map['dateTime'] as String),
    );
  }

  Note copyWith({
    int? id,
    String? title,
    String? content,
    Color? color,
    DateTime? dateTime,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      color: color ?? this.color,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.content == content &&
        other.color == color &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        color.hashCode ^
        dateTime.hashCode;
  }
}
