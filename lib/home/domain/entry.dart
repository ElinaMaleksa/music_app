import 'package:music_app/home/domain/common/label_attributes.dart';
import 'package:music_app/home/domain/common/attributes_only.dart';
import 'package:music_app/home/domain/content_type.dart';
import 'package:music_app/home/domain/common/label_only.dart';

class Entry {
  LabelOnly? imName;
  List<LabelAttributes?>? imImage;
  LabelOnly? imItemCount;
  LabelAttributes? imPrice;
  ImContentType? imContentType;
  LabelOnly? rights;
  LabelOnly? title;
  AttributesOnly? link;
  LabelAttributes? id;
  LabelAttributes? imArtist;
  AttributesOnly? category;
  LabelAttributes? imReleaseDate;

  Entry(
      {this.imName,
      this.imImage,
      this.imItemCount,
      this.imPrice,
      this.imContentType,
      this.rights,
      this.title,
      this.link,
      this.id,
      this.imArtist,
      this.category,
      this.imReleaseDate});

  Entry.fromJson(Map<String, dynamic> json) {
    imName = json['im:name'] != null ? LabelOnly?.fromJson(json['im:name']) : null;
    if (json['im:image'] != null) {
      imImage = <LabelAttributes>[];
      json['im:image'].forEach((v) => imImage!.add(LabelAttributes.fromJson(v)));
    }
    imItemCount = json['im:itemCount'] != null ? LabelOnly?.fromJson(json['im:itemCount']) : null;
    imPrice = json['im:price'] != null ? LabelAttributes?.fromJson(json['im:price']) : null;
    imContentType = json['im:contentType'] != null ? ImContentType?.fromJson(json['im:contentType']) : null;
    rights = json['rights'] != null ? LabelOnly?.fromJson(json['rights']) : null;
    title = json['title'] != null ? LabelOnly?.fromJson(json['title']) : null;
    link = json['link'] != null ? AttributesOnly?.fromJson(json['link']) : null;
    id = json['id'] != null ? LabelAttributes?.fromJson(json['id']) : null;
    imArtist = json['im:artist'] != null ? LabelAttributes?.fromJson(json['im:artist']) : null;
    category = json['category'] != null ? AttributesOnly?.fromJson(json['category']) : null;
    imReleaseDate = json['im:releaseDate'] != null ? LabelAttributes?.fromJson(json['im:releaseDate']) : null;
  }
}
