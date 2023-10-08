import '../../domain/entities/Local.dart';

class LocalModel extends Local {
  LocalModel(
      {required String id,
      required String title,
      required String body,
      required String img})
      : super(id: id, title: title, body: body, img: img);

  factory LocalModel.fromJson(Map<String, dynamic> json) {
    return LocalModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      img: json['img'],
    );
  }

  factory LocalModel.fromEntity(Local local) {
    return LocalModel(
      id: local.id,
      title: local.title,
      body: local.body,
      img: local.img,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'img': img,
    };
  }
}
