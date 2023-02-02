class LabelOnly {
  String? label;

  LabelOnly({this.label});

  LabelOnly.fromJson(Map<String, dynamic> json) {
    label = json['label'];
  }
}
