import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 8, 1, 55),
            strokeWidth: 5.0,
          ),
        ),
      ),
    );
  }
}
