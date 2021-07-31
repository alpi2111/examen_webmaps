import 'package:flutter/material.dart';

Future<void> showCustomLoadingDialog({required BuildContext context, required String titulo, bool dismis = false}) {
  return showDialog(
    context: context,
    barrierDismissible: dismis,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [CircularProgressIndicator()],
      ),
      title: Text('$titulo'),
    ),
  );
}

Future<void> showCustomContentTextDialog({required BuildContext context, required String titulo, bool dismis = false, required String contenido}) {
  return showDialog(
    context: context,
    barrierDismissible: dismis,
    builder: (context) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Text('$contenido')],
      ),
      title: Text('$titulo'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Ok'),
        ),
      ],
    ),
  );
}
