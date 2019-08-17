import 'package:flutter/material.dart';

void showUnavailableMessage(BuildContext context) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Aún no disponible'),
      ),
    );
  }