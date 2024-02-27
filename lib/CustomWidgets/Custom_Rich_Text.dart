import 'package:flutter/cupertino.dart';

class RichTxt extends StatefulWidget {
  final FontStyle fontStyle;
  final FontStyle? fontStyle1;
  final FontStyle? fontStyle2;
  final FontStyle? fontStyle3;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight1;
  final FontWeight? fontWeight2;
  final FontWeight? fontWeight3;
  final int? maxlines;
  final double? fontSize;
  final double? fontSize1;
  final double? fontSize2;
  final double? fontSize3;
  final Color? color;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final TextAlign? textAlign;
  final bool useoverflow;
  final bool upperCaseFirst;
  final bool upperCaseSecond;
  final bool upperCaseThird;
  final bool upperCaseForth;
  final bool useQuotes;
  final bool useQuotes1;
  final bool useQuotes2;
  final bool useQuotes3;
  final bool useFiler;
  final bool useFiler1;
  final bool useFiler2;
  final bool useFiler3;
  final bool underlined;
  final bool underlined1;
  final bool underlined2;
  final bool underlined3;
  final bool fullUpperCase;
  final bool fullLowerCase;
  final dynamic text;
  final dynamic text1;
  final dynamic text2;
  final dynamic text3;
  final String? fontFamily;
  final bool lineThrough;


  const RichTxt({
    Key? key,
    required this.fontStyle,
    this.fontWeight,
    this.maxlines,
    this.fontSize,
    this.color,
    this.textAlign,
    this.useoverflow = false,
    this.upperCaseFirst = false,
    this.useQuotes = false,
    this.useFiler = false,
    this.underlined = false,
    this.fullUpperCase = false,
    this.fullLowerCase = false,
    required this.text,
    this.fontFamily,
    required this.text1,
    this.fontStyle1,
    this.fontWeight1,
    this.fontSize1,
    this.color1,
    this.underlined1 = false,
    this.fontStyle2,
    this.fontStyle3,
    this.fontWeight2,
    this.fontWeight3,
    this.fontSize2,
    this.fontSize3,
    this.color2,
    this.color3,
    this.underlined2 = false,
    this.underlined3 = false,
    this.text2, this.text3,
    this.upperCaseSecond = false,
    this.upperCaseThird = false,
    this.upperCaseForth = false,
    this.useQuotes1 = false,
    this.useQuotes2 = false,
    this.useQuotes3 = false,
    this.useFiler1 = false,
    this.useFiler2 = false,
    this.useFiler3 = false,
    this.lineThrough = false,
  }) : super(key: key);

  @override
  _RichTxtState createState() => _RichTxtState();
}

class _RichTxtState extends State<RichTxt> {
  String finalText = "Null";
  String finalText1 = "Null";
  String finalText2 = "Null";
  String finalText3 = "Null";

  @override
  Widget build(BuildContext context) {
    bool isString = widget.text is String;
    bool isNumber = widget.text is double || widget.text is int;
    bool isOthers = isString == false && isNumber == false;

    if (isString)
      finalText = widget.text ??
          ""; //when you forgot to set a value, "Error" will be shown
    if (isNumber) finalText = '${widget.text}';
    if (isOthers) finalText = "Invalid input ${widget.text}";

    bool isString1 = widget.text1 is String;
    bool isNumber1 = widget.text1 is double || widget.text1 is int;
    bool isOthers1 = isString1 == false && isNumber1 == false;

    if (isString1)
      finalText1 = widget.text1 ??
          ""; //when you forgot to set a value, "Error" will be shown
    if (isNumber1) finalText1 = '${widget.text1}';
    if (isOthers1) finalText1 = "Invalid input ${widget.text1}";

    bool isString2 = widget.text1 is String;
    bool isNumber2 = widget.text1 is double || widget.text1 is int;
    bool isOthers2 = isString2 == false && isNumber2 == false;

    if (isString2) finalText2 = widget.text2 ?? ""; //when you forgot to set a value, "Error" will be shown
    if (isNumber2) finalText2 = '${widget.text2}';
    if (isOthers2) finalText2 = "Invalid input ${widget.text2}";

    bool isString3 = widget.text3 is String;
    bool isNumber3 = widget.text3 is double || widget.text3 is int;
    bool isOthers3 = isString3 == false && isNumber3 == false;

    if (isString3) {
      finalText3 = widget.text3 ??
          "";
    } //when you forgot to set a value, "Error" will be shown
    if (isNumber3) finalText3 = '${widget.text3}';
    if (isOthers3) finalText3 = "Invalid input ${widget.text3}";


//John → john
    if (widget.fullLowerCase) finalText = finalText.toLowerCase();
    if (widget.fullLowerCase) finalText1 = finalText1.toLowerCase();
    if (widget.fullLowerCase) finalText2 = finalText2.toLowerCase();
    if (widget.fullLowerCase) finalText3 = finalText3.toLowerCase();

//John → JOHN
    if (widget.fullUpperCase) finalText = finalText.toUpperCase();
    if (widget.fullUpperCase) finalText1 = finalText1.toUpperCase();
    if (widget.fullUpperCase) finalText2 = finalText2.toUpperCase();
    if (widget.fullUpperCase) finalText3 = finalText3.toUpperCase();

//JOHN or john → John
    if (widget.upperCaseFirst && finalText.length > 1) {
      finalText =
          "${finalText[0].toUpperCase()}${finalText.substring(1, finalText.length).toLowerCase()}";
    }
    if (widget.upperCaseSecond && finalText1.length > 1) {
      finalText1 =
          "${finalText1[0].toUpperCase()}${finalText1.substring(1, finalText1.length).toLowerCase()}";
    }
    if (widget.upperCaseThird && finalText2.length > 1) {
      finalText2 =
      "${finalText2[0].toUpperCase()}${finalText2.substring(1, finalText2.length).toLowerCase()}";
    }
    if (widget.upperCaseForth && finalText3.length > 1) {
      finalText3 =
      "${finalText3[0].toUpperCase()}${finalText3.substring(1, finalText3.length).toLowerCase()}";
    }

//John → "John"
    if (widget.useQuotes) finalText = "❝$finalText❞";
    if (widget.useQuotes1) finalText1 = "❝$finalText1❞";
    if (widget.useQuotes2) finalText2 = "❝$finalText2❞";
    if (widget.useQuotes3) finalText3 = "❝$finalText3❞";

//John*_-#![] → John
    if (widget.useFiler) {
      finalText = finalText
          .replaceAll("*", "")
          .replaceAll("_", "")
          .replaceAll("-", "")
          .replaceAll("#", "")
          .replaceAll("\n", "")
          .replaceAll("!", "")
          .replaceAll('[', '')
          .replaceAll(']', '');
    }
    if (widget.useFiler1) {
      finalText1 = finalText1
          .replaceAll("*", "")
          .replaceAll("_", "")
          .replaceAll("-", "")
          .replaceAll("#", "")
          .replaceAll("\n", "")
          .replaceAll("!", "")
          .replaceAll('[', '')
          .replaceAll(']', '');
    }
    if (widget.useFiler2) {
      finalText2 = finalText2
          .replaceAll("*", "")
          .replaceAll("_", "")
          .replaceAll("-", "")
          .replaceAll("#", "")
          .replaceAll("\n", "")
          .replaceAll("!", "")
          .replaceAll('[', '')
          .replaceAll(']', '');
    }
    if (widget.useFiler3) {
      finalText3 = finalText3
          .replaceAll("*", "")
          .replaceAll("_", "")
          .replaceAll("-", "")
          .replaceAll("#", "")
          .replaceAll("\n", "")
          .replaceAll("!", "")
          .replaceAll('[', '')
          .replaceAll(']', '');
    }

    return RichText(
      overflow: widget.useoverflow ? TextOverflow.ellipsis : TextOverflow.visible,
      textAlign: widget.textAlign ?? TextAlign.start,
      maxLines: widget.maxlines,
      textScaleFactor: 1,
      // This will keep your text size constant, when the user changes his device text size,
      text: TextSpan(
        text: (finalText.isEmpty ? "" : finalText).toString(),
        style: TextStyle(  fontFamily: 'Quicksand',

          decoration: widget.underlined ? TextDecoration.underline : null,
          //to underlined a text
          color: widget.color,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
          fontStyle: widget.fontStyle,
        ),
        children: <TextSpan>[
          TextSpan(
            text: (finalText1.isEmpty ? "" : finalText1).toString(),
            style: TextStyle(  fontFamily: 'Quicksand',
              decoration: widget.underlined ? TextDecoration.underline : widget.lineThrough ? TextDecoration.lineThrough : null,
              //to underlined a text
              // decoration: widget.underlined1 ? TextDecoration.underline : null,
              //to underlined a text
              color: widget.color1,
              fontSize: widget.fontSize1,
              fontWeight: widget.fontWeight1,
              fontStyle: widget.fontStyle1,
            ),
          ),
          TextSpan(
            text: (finalText2.isEmpty ? "" : finalText2).toString(),
            style: TextStyle(  fontFamily: 'Quicksand',

              decoration: widget.underlined2 ? TextDecoration.underline : null,
              //to underlined a text
              color: widget.color2,
              fontSize: widget.fontSize2,
              fontWeight: widget.fontWeight2,
              fontStyle: widget.fontStyle2,
            ),
          ),
          TextSpan(
            text: (finalText3.isEmpty ? "" : finalText3).toString(),
            style: TextStyle(  fontFamily: 'Quicksand',

              decoration: widget.underlined3 ? TextDecoration.underline : null,
              //to underlined a text
              color: widget.color3,
              fontSize: widget.fontSize3,
              fontWeight: widget.fontWeight3,
              fontStyle: widget.fontStyle3,
            ),
          ),
        ],
      ),
    );
  }
}
