import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    this.message = 'Product is empty',
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return VStack(
      [
        Icon(
          Icons.remove_circle_outline,
          size: 64,
          color: Colors.red,
        ).centered(),
        SizedBox(height: 8),
        Text(
          message,
          style: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ).centered()
      ],
    );
  }
}
