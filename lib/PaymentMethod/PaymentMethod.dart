import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodzi/theme/colors.dart';

class PaymentMethod extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PaymentmethodState();
}

class _PaymentmethodState extends State<PaymentMethod> {
  // final numberController = TextEditingController();
  // PaymentCard _paymentCard;
  // CardType _cardType;
  FocusNode myFocusNode = new FocusNode();
  FocusNode cvvFocus = new FocusNode();
   FocusNode expiryDateFocus = new FocusNode();
   
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidate = false;
 FocusNode cardNameFocus = new FocusNode();
  var _card = new PaymentCard();

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white70,
      ),
      body: _getmainview(),
      bottomNavigationBar: BottomAppBar(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 54,
            decoration: BoxDecoration(
                color: greentheme100,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15))),
            // color: redtheme,
            child: Center(
              child: Text(
                'ADD',
                style: TextStyle(
                    fontFamily: 'gotham',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ),
          // ),
          // ],
          // )
        ),
      ),
    );
  }

  Widget _getmainview() {
    return Form(
      key: _formKey,
      autovalidate: _autoValidate,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                'Card Number',
                style: TextStyle(
                    height: 3,
                    letterSpacing: 0.32,
                    fontSize: 16,
                    color: greytheme700),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 22),
            child: Container(
              height: 41,
              child: new TextFormField(
                focusNode: myFocusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(19),
                  new CardNumberInputFormatter()
                ],
                controller: numberController,
                decoration: new InputDecoration(
                    prefixIcon: CardUtils.getCardIcon(_paymentCard.type),
                    contentPadding: EdgeInsets.all(12.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greentheme100, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greytheme900, width: 2)),
                    //  icon: CardUtils.getCardIcon(_paymentCard.type),
                    hintText: 'What number is written on card?',
                    labelText: myFocusNode.hasFocus
                        ? 'Card Number'
                        : '**** **** **** ****',
                    labelStyle: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        wordSpacing: 8,
                        color:  myFocusNode.hasFocus?greentheme100:greytheme100)),
                onSaved: (String value) {
                  print('onSaved = $value');
                  print('Num controller has = ${numberController.text}');
                  _paymentCard.number = CardUtils.getCleanedNumber(value);
                },
                validator: CardUtils.validateCardNum,
              ),
            ),
          ),
          // SizedBox(
          //   height:15,
          // ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Text(
                'Valid Until',
                style: TextStyle(
                    height: 3,
                    letterSpacing: 0.32,
                    fontSize: 16,
                    color: greytheme700),
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // Align(
          //   alignment: Alignment.centerLeft,
          // child:
          Container(
             width: 148,
             height: 41,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
              ),
              child: Container(
                width: 150,
                child: new TextFormField(
                  focusNode: expiryDateFocus,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(4),
                    new CardMonthInputFormatter()
                  ],
                  decoration: new InputDecoration(
                      contentPadding: EdgeInsets.all(12.0),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greentheme100, width: 2),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: greytheme900, width: 2)),
                      hintText: 'MM/YY',
                      labelText: 'Expiry Date',
                      labelStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          // wordSpacing: 8,
                          color: expiryDateFocus.hasFocus?greentheme100:greytheme100)),
                  validator: CardUtils.validateDate,
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    List<int> expiryDate = CardUtils.getExpiryDate(value);
                    _paymentCard.month = expiryDate[0];
                    _paymentCard.year = expiryDate[1];
                  },
                ),
              ),
            ),
          ),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              'Card Holder',
              style: TextStyle(
                  height: 3,
                  letterSpacing: 0.32,
                  fontSize: 16,
                  color: greytheme700),
            ),
          ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 22),
            child: Container(
              height: 41,
              child: new TextFormField(
                 focusNode: cardNameFocus,
                 inputFormatters: [],
                decoration:  InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: greentheme100, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greytheme900, width: 2)),
                    hintText: 'What name is written on card?',
                    labelText: 'Your Name on Card',
                    labelStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // wordSpacing: 8,
                        color: cardNameFocus.hasFocus ?greentheme100:greytheme100
                        // color: greytheme100
                        )),
                onSaved: (String value) {
                  _card.name = value;
                },
                keyboardType: TextInputType.text,
                validator: (String value) =>
                    value.isEmpty ? Strings.fieldReq : null,
              ),
            ),
          ),
          // SizedBox(
          //   height: 15,
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              'CVV',
              style: TextStyle(
                  height: 3,
                  letterSpacing: 0.32,
                  fontSize: 16,
                  color: greytheme700),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    width: 148,
                    height: 41,
                    child: TextFormField(
                      focusNode: cvvFocus,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        new LengthLimitingTextInputFormatter(4),
                      ],
                      decoration: new InputDecoration(
                          contentPadding: EdgeInsets.all(12.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: greentheme100, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: greytheme900, width: 2)),
                          hintText: '***',
                          labelText: cvvFocus.hasFocus ? "CVV" : "***",
                          labelStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              wordSpacing: 8,
                              color: cvvFocus.hasFocus?greentheme100:greytheme100)),
                      validator: CardUtils.validateCVV,
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _paymentCard.cvv = int.parse(value);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 25,
                ),
                SizedBox(
                    width: 147,
                    height: 26,
                    child: Text(
                      ''' The last three digits \t On the back of the card''',
                      style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 0.24,
                          color: greytheme100),
                    )),
                // SizedBox(
                //   width: 31,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}

enum CardType {
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}

class PaymentCard {
  CardType type;
  String number;
  String name;
  int month;
  int year;
  int cvv;

  PaymentCard(
      {this.type, this.number, this.name, this.month, this.year, this.cvv});

  @override
  String toString() {
    return '[Type: $type, Number: $number, Name: $name, Month: $month, Year: $year, CVV: $cvv]';
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class CardUtils {
  static String validateCVV(String value) {
    if (value.isEmpty) {
      return Strings.fieldReq;
    }

    if (value.length < 3 || value.length > 4) {
      return "CVV is invalid";
    }
    return null;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = new RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static String validateCardNum(String input) {
    if (input.isEmpty) {
      return Strings.fieldReq;
    }

    input = getCleanedNumber(input);

    if (input.length < 8) {
      return Strings.numberIsInvalid;
    }

    int sum = 0;
    int length = input.length;
    for (var i = 0; i < length; i++) {
      // get digits in reverse order
      int digit = int.parse(input[length - i - 1]);

      // every 2nd number multiply with 2
      if (i % 2 == 1) {
        digit *= 2;
      }
      sum += digit > 9 ? (digit - 9) : digit;
    }

    if (sum % 10 == 0) {
      return null;
    }

    return Strings.numberIsInvalid;
  }

  static Widget getCardIcon(CardType cardType) {
    String img = "";
    Icon icon;
    switch (cardType) {
      case CardType.Master:
        img = 'mastercard.png';
        break;
      case CardType.Visa:
        img = 'visa.png';
        break;
      case CardType.Verve:
        img = 'verve.png';
        break;
      case CardType.AmericanExpress:
        img = 'american_express.png';
        break;
      case CardType.Discover:
        img = 'discover.png';
        break;
      case CardType.DinersClub:
        img = 'dinners_club.png';
        break;
      case CardType.Jcb:
        img = 'jcb.png';
        break;
      case CardType.Others:
        icon = new Icon(
          Icons.credit_card,
          size: 35.0,
          color: Colors.grey[600],
        );
        break;
      case CardType.Invalid:
        icon = new Icon(
          Icons.warning,
          size: 35.0,
          color: Colors.grey[600],
        );
        break;
    }
    Widget widget;
    if (img.isNotEmpty) {
      widget = new Image.asset(
        // 'assets/images/$img',
        'assets/PaymentCard/$img',
        width: 35.0,
      );
    } else {
      widget = icon;
    }
    return widget;
  }

  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(new RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(new RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input
        .startsWith(new RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.startsWith(new RegExp(r'((34)|(37))'))) {
      cardType = CardType.AmericanExpress;
    } else if (input.startsWith(new RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.Discover;
    } else if (input
        .startsWith(new RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.DinersClub;
    } else if (input.startsWith(new RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.Jcb;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static String validateDate(String value) {
    if (value.isEmpty) {
      return Strings.fieldReq;
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return 'Expiry month is invalid';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return 'Expiry year is invalid';
    }

    if (!hasDateExpired(month, year)) {
      return "Card has expired";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(new RegExp(r'(\/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }
}

class Strings {
  static const String appName = 'Payment Card Demo';
  static const String fieldReq = 'This field is required';
  static const String numberIsInvalid = 'Card is invalid';
  static const String pay = 'Pay';
}
