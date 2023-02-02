import 'package:music_app/home/domain/common/attributes.dart';

class ImContentType {
  ImContentType? imContentType;
  Attributes? attributes;

  ImContentType({this.imContentType, this.attributes});

  ImContentType.fromJson(Map<String, dynamic> json) {
    imContentType = json['im:contentType'] != null ? ImContentType?.fromJson(json['im:contentType']) : null;
    attributes = json['attributes'] != null ? Attributes?.fromJson(json['attributes']) : null;
  }
}
