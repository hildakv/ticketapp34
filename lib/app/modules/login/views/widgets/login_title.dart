import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        // Text(
        //   'Login',
        //   style: TextStyle(
        //     fontSize: 24,
        //     fontWeight: FontWeight.w400,
        //     color: Colors.white,
        //   ),
        // ),
        SizedBox(height: 10),
        Center(
          child: Text(
            'Keltron Ticket Solution',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
