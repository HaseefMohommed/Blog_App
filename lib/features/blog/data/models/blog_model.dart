import 'dart:convert';

import 'package:blog_app/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
    super.posterName,
  });

  // Convert the BlogModel instance to a JSON map, encoding the topics as a JSON string for sqflite
  Map<String, dynamic> toJson({bool isFromSupabase = false}) {
    return <String, dynamic>{
      'id': id.toString(),
      'poster_id': posterId.toString(),
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': isFromSupabase ? topics : jsonEncode(topics),
      'updated_at': updatedAt.toIso8601String(),
      if (posterName != null) 'poster_name': posterName,
    };
  }

  // Create a BlogModel instance from a JSON map, decoding the topics as needed
  factory BlogModel.fromJson(Map<String, dynamic> map, {bool isFromSupabase = false}) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['poster_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['image_url'] as String,
      topics: isFromSupabase
          ? List<String>.from(map['topics']?? '[]') // Directly use the array for Supabase
          : List<String>.from(jsonDecode(map['topics'] ?? '[]')), // Decode the JSON string for sqflite
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at'] as String),
      posterName: map['poster_name'] as String?,
    );
  }

  BlogModel copyWith({
    String? id,
    String? posterId,
    String? title,
    String? content,
    String? imageUrl,
    List<String>? topics,
    DateTime? updatedAt,
    String? posterName,
  }) {
    return BlogModel(
      id: id ?? this.id,
      posterId: posterId ?? this.posterId,
      title: title ?? this.title,
      content: content ?? this.content,
      imageUrl: imageUrl ?? this.imageUrl,
      topics: topics ?? this.topics,
      updatedAt: updatedAt ?? this.updatedAt,
      posterName: posterName ?? this.posterName,
    );
  }
}
