class Globle {
  static final Globle _globle = Globle.internal();

  factory Globle() {
    return _globle;
  }

  Globle.internal();

  var authKey;
}
