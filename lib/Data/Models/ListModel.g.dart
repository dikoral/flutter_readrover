// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      description: json['description'] as String,
      imagePath: json['image_path'] as String,
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'author': instance.author,
      'description': instance.description,
      'image_path': instance.imagePath,
    };
