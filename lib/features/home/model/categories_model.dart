import 'package:equatable/equatable.dart';

final class Categories extends Equatable {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  Categories({this.postId, this.id, this.name, this.email, this.body});

  Categories.fromJson(Map<String, dynamic> json) {
    postId = json['postId'];
    id = json['id'];
    name = json['name'];
    email = json['email'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['postId'] = postId;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['body'] = body;
    return data;
  }

  @override
  List<Object?> get props => [postId, id, name, email, body];
}
