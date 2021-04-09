class Currency {
  String from,to;
  double result=300;

  Currency(this.from,this.to);
  

  Currency.fromJson(Map<String, dynamic> json) {
    
    result = json["USD_TND"];
  }

  Map<String, dynamic> toJson() {
    
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["USD_TND"] = this.result;
    return data;
  }
}
