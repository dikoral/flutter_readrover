import 'package:json_annotation/json_annotation.dart';

part 'ListModel.g.dart';

@JsonSerializable()
class Book {
  int id;
  String title;
  String author;
  String description;
  @JsonKey(name: 'image_path')
  String imagePath;

  Book({required this.id, required this.title, required this.author, required this.description, required this.imagePath});

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
  Map<String, dynamic> toJson() => _$BookToJson(this);
}