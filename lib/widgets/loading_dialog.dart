import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {

  final String ? message;

  LoadingDialog({this.message});
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(height: 10,),
          Text( message!  + " , Please wait ..."),
          
        ],
      ),
    );
  }
}


circularProgress(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(
        Colors.amber
      ),

    ),


  );
}