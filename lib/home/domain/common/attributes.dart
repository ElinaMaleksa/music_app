class Attributes {
  String? height;
  String? rel;
  String? type;
  String? href;
  String? amount;
  String? currency;
  String? term;
  String? label;
  String? imId;
  String? scheme;

  Attributes(
      {this.height,
      this.rel,
      this.type,
      this.href,
      this.amount,
      this.currency,
      this.term,
      this.label,
      this.imId,
      this.scheme});

  Attributes.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    rel = json['rel'];
    type = json['type'];
    href = json['href'];
    amount = json['amount'];
    currency = json['currency'];
    term = json['term'];
    label = json['label'];
    imId = json['im:id'];
    scheme = json['scheme'];
  }
}
