import 'package:chat_app/core/extensions/context_extansion.dart';
import 'package:flutter/material.dart';

Future<bool> showConfirmationDialog(
    BuildContext context, String messageHeader, String contentMessage, Function()? onConfirm) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(messageHeader, style: context.bigTextStyle),
        content: Text(
          contentMessage,
          style: context.normalTextStyle,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Hayır"),
          ),
          TextButton(
            onPressed: onConfirm,
            child: const Text("Evet"),
          ),
        ],
      );
    },
  );
}
