class CoronaData {
  String country;
  int confirmed;
  int recovered;
  int deaths;

  CoronaData({this.country, this.confirmed, this.recovered, this.deaths});

  @override
  String toString() {
    return 'CoronaData{country: $country, confirmed: $confirmed, recovered: $recovered, deaths: $deaths}';
  }
}

