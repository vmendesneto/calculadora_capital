class Currency {
  USDBRL? Parity;

  Currency({this.Parity});

  Currency.fromJson(String key,Map<String, dynamic> json) {
    Parity =
    json[key] != null ? USDBRL.fromJson(json[key]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.Parity != null) {
      data['USDBRL'] = this.Parity!.toJson();
    }
    return data;
  }
}

class USDBRL {
  String? code;
  String? codein;
  String? name;
  String? high;
  String? low;
  String? varBid;
  String? pctChange;
  String? bid;
  String? ask;
  String? timestamp;
 String? createDate;

  USDBRL(
      {this.code,
        this.codein,
        this.name,
        this.high,
        this.low,
        this.varBid,
        this.pctChange,
        this.bid,
        this.ask,
        this.timestamp,
        this.createDate});

  USDBRL.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    codein = json['codein'];
    name = json['name'];
    high = json['high'];
    low = json['low'];
    varBid = json['varBid'];
    pctChange = json['pctChange'];
    bid = json['bid'];
    ask = json['ask'];
    timestamp = json['timestamp'];
    createDate = json['create_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    data['codein'] = this.codein;
    data['name'] = this.name;
    data['high'] = this.high;
    data['low'] = this.low;
    data['varBid'] = this.varBid;
    data['pctChange'] = this.pctChange;
    data['bid'] = this.bid;
    data['ask'] = this.ask;
    data['timestamp'] = this.timestamp;
    data['create_date'] = this.createDate;
    return data;
  }
}