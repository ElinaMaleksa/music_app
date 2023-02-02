import 'package:music_app/home/domain/common/attributes.dart';

class LabelAttributes {
  String? label;
  Attributes? attributes;

  LabelAttributes({this.label, this.attributes});

  LabelAttributes.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    attributes = json['attributes'] != null ? Attributes?.fromJson(json['attributes']) : null;
  }
}
