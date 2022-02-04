import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color color;
  final String button_name;
  final VoidCallback onPress;
  final IconData icon;

  RoundedButton(
      {required this.color,
      required this.button_name,
      required this.onPress,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,

          minWidth: 200.0,
          height: 42.0,

          // child: Text(button_name,style: TextStyle(color: Colors.white),),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon),
                SizedBox(
                  width: 10,
                ),
                Text(
                  button_name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Button1 extends StatelessWidget {
  final Color color;
  final String button_name;
  final VoidCallback onPress;

  Button1(
      {required this.color, required this.button_name, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,

          minWidth: 200.0,
          height: 42.0,

          // child: Text(button_name,style: TextStyle(color: Colors.white),),
          child: Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  button_name,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
