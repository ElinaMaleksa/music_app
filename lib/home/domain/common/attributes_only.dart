import 'package:music_app/home/domain/common/attributes.dart';

class AttributesOnly {
  Attributes? attributes;

  AttributesOnly({this.attributes});

  AttributesOnly.fromJson(Map<String, dynamic> json) {
    attributes = json['attributes'] != null ? Attributes?.fromJson(json['attributes']) : null;
  }
}
