import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_collegeapp/common/resources.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppBar Header(BuildContext context, {bool isMenu = true}){
  return AppBar(
    leading: isMenu ?
      IconButton(
        onPressed: () => Navigator.pushNamed(context, 'menu'),
        icon: Image.asset('assets/hamburger.png'),
        iconSize: 120,
      )
    : IconButton(
      icon: Image.asset('assets/back.png'),
      iconSize: 120,
      onPressed: () => Navigator.pop(context),
    ),
    toolbarHeight: 80.0,
    automaticallyImplyLeading: true,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );
}

Widget HomeButton(BuildContext context){
  return Container(
    height: 80,
    width: MediaQuery.of(context).size.width,
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 20,
            child: IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => false);
                Navigator.pushNamed(context, 'root');
              },
              icon: Image.asset("assets/home.png"),
              iconSize: 45,
            ))
      ],
    ),
  );
}

Widget TimePicker(BuildContext context, int startHour, int startMinute, int endHour, int endMinute, Function(int value) onStartHourChanged, Function(int value) onStartMinuteChanged, Function(int value) onEndHourChanged, Function(int value) onEndMinuteChanged, ){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Text(
        AppLocalizations.of(context)?.start ?? 'Start:',
        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
      ),
      NumberPicker(
        itemHeight: 40,
        itemWidth: 50.0,
        minValue: 8,
        maxValue: 20,
        onChanged: (value) => onStartHourChanged(value),
        value: startHour,
        selectedTextStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
        textStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 14, color: Color(0xFF4F4F4F)),
      ),
      Text(
        ":",
        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
      ),
      NumberPicker(
        itemHeight: 40,
        itemWidth: 50.0,
        minValue: 0,
        maxValue: 59,
        onChanged: (value) => onStartMinuteChanged(value),
        value: startMinute,
        textMapper: (numberText) {
          return addZero(int.parse(numberText));
        },
        selectedTextStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
        textStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 14, color: Color(0xFF4F4F4F)),
      ),
      Text(
        AppLocalizations.of(context)?.end ?? 'End:',
        style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
      ),
      NumberPicker(
        itemHeight: 40,
        itemWidth: 50.0,
        minValue: 8,
        maxValue: 20,
        onChanged: (value) => onEndHourChanged(value),
        value: endHour,
        selectedTextStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
        textStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 14, color: Color(0xFF4F4F4F)),
      ),
      Text(
        ":",
        style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
      ),
      NumberPicker(
        itemHeight: 40,
        itemWidth: 50.0,
        minValue: 0,
        maxValue: 59,
        onChanged: (value) => onEndMinuteChanged(value),
        value: endMinute,
        textMapper: (numberText) {
          return addZero(int.parse(numberText));
        },
        selectedTextStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
        textStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 14, color: Color(0xFF4F4F4F)),
      ),
    ],
  );
}

String addZero(int value){
  switch(value){
    case 0: return "00";
    case 1: return "01";
    case 2: return "02";
    case 3: return "03";
    case 4: return "04";
    case 5: return "05";
    case 6: return "06";
    case 7: return "07";
    case 8: return "08";
    case 9: return "09";
    default: return value.toString();
  }
}

Future<void> showErrorAlert(String text, BuildContext context) async {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xD5FF5252),
          scrollable: true,
          title: Text(
            AppLocalizations.of(context)?.error ?? "Error",
            style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24, color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Flexible(
              child: Text(
                text,
                style: Resources.customTextStyles.getCustomTextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
  );
}

Future<bool?> showContinueAlert(String text, BuildContext context) async {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Color(0xFFBED7BF),
        scrollable: true,
        title: Text(
          AppLocalizations.of(context)?.error ?? "Error",
          style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 24),
        ),
        content: SingleChildScrollView(
          child: Flexible(
            child: Text(
              text,
              style: Resources.customTextStyles.getCustomTextStyle(fontSize: 16),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              AppLocalizations.of(context)?.cancel ?? 'Cancel',
              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: Text(
              AppLocalizations.of(context)?.ok ?? 'OK',
              style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}

void showSnackBar(BuildContext context, String text, {Function()? onActionPressed, Color? color}) {
  var snackBar = SnackBar(
    content: Text(text, style: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20)),
    backgroundColor: color ?? Resources.customColors.snackBarGreen,
    action: SnackBarAction(
      label: onActionPressed != null ? AppLocalizations.of(context)?.ok ?? 'OK' : '',
      textColor: Colors.white,
      onPressed: (){
        if(onActionPressed != null){
          onActionPressed();
        }
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
    duration: onActionPressed != null ? Duration(seconds: 30) : Duration(seconds: 4),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

TextFormField CustomTextFormField(TextEditingController controller, TextInputType keyBoardType, {String? hintText, int? maxLines}){
  return TextFormField(
    controller: controller,
    cursorColor: Resources.customColors.cursorGreen,
    cursorHeight: 20,
    keyboardType: keyBoardType,
    minLines: 1,
    maxLines: maxLines ?? 1,
    style: Resources.customTextStyles.getCustomTextStyle(fontSize: 20),
    decoration: InputDecoration(
        hintText: hintText ?? '',
        hintStyle: Resources.customTextStyles.getCustomBoldTextStyle(fontSize: 20, color: Color(0xFF828282)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Resources.customColors.cursorGreen)
        )
    ),
  );
}