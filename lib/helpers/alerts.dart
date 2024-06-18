import 'package:flutter/material.dart';

void showError(context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      backgroundColor: Theme.of(context).colorScheme.error,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showSuccessMessage(context, String message, void Function()? callback,
    {Duration duration = const Duration(seconds: 4)}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: GestureDetector(
        onTap: () {
          if (callback != null) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            callback();
          }
        },
        child: Text(
          message,
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 61, 226, 146),
      behavior: SnackBarBehavior.floating,
      duration: duration,
    ),
  );
}
