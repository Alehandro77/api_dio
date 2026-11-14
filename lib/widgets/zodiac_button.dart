import 'package:flutter/material.dart';

class ZodiacButton extends StatelessWidget {
  final String zodiac;
  final VoidCallback onPressed;

  const ZodiacButton({
    super.key,
    required this.zodiac,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(zodiac[0].toUpperCase() + zodiac.substring(1)),
    );
  }
}
