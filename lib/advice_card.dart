import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AdviceText extends StatefulWidget {
  const AdviceText({super.key});

  @override
  State<AdviceText> createState() => _AdviceTextState();
}

class _AdviceTextState extends State<AdviceText> {
  final String adviceUrl = 'https://api.adviceslip.com/advice';
  String advice = 'Random advice to make your day';
  int id = 0;

  generateAdvice() async {
    var res = await http.get(Uri.parse(adviceUrl));
    var result = jsonDecode(res.body);

    setState(() {
      advice = result["slip"]["advice"];
      id = result["slip"]["id"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 400,
          width: double.infinity,
          child: Card(
            margin: const EdgeInsets.all(20),
            color: const Color(0xFF4E5D73),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 30, bottom: 20, left: 20, right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'ADVICE #$id',
                      style: GoogleFonts.manrope(
                          color: const Color(0xFF52FFA8),
                          fontSize: 16,
                          letterSpacing: 3.0),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      advice,
                      style: GoogleFonts.manrope(
                          color: const Color(0xFFcee3e9),
                          fontSize: 28,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ]),
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF52FFA8),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: generateAdvice,
          child: const Icon(
            Icons.skip_next,
            color: Colors.black,
            size: 30,
          ),
        ),
      ],
    );
  }
}
