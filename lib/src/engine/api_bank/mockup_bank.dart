class Bank {
  String? ispb;
  String? name;
  int? code;
  String? fullName;

  Bank(String ispb, String name, int code, String fullName) {
    this.ispb = ispb;
    this.name = name;
    this.code = code;
    this.fullName = fullName;
  }

  Bank.fromJson(Map json)
      : ispb = json['ispb'],
        name = json['name'],
        code = json['code'],
        fullName = json['fullName'];
}
