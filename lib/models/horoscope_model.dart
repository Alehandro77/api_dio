class Horoscope {
  final String date;
  final String sign;
  final String text;

  Horoscope({required this.date, required this.sign, required this.text});

  factory Horoscope.fromJson(Map<String, dynamic> json) {
    return Horoscope(
      date: json['date'] as String,
      sign: json['sign'] as String,
      text: json['horoscope'] as String,
    );
  }
}
