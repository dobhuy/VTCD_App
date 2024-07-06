import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:vtcc_app/src/screens/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        ClipPath(
          clipper: CustomClipPathPurpleAccent(context: context),
          child: Container(
            color: Colors.deepPurpleAccent,
          ),
        ),
        ClipPath(
          clipper: CustomClipPathPurple(context: context),
          child: Container(
            color: Colors.deepPurple,
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'VTCD',
                // style: TextStyle(
                //   fontSize: 40,
                //   fontWeight: FontWeight.bold,
                //   // Create a hand written font style
                //   fontFamily: 'DancingScript',
                //   color: Color.fromARGB(255, 74, 32, 146),
                // ),
                style: GoogleFonts.courgette(
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 74, 32, 146),
                ),
              ),
              const FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Vietnamese Traditional Cake Detection App',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 74, 32, 146),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  child: HelpButton(onHelpPressed: () {
                    // show alert box
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                            'How to use this app?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Colors.deepPurple,
                            ),
                          ),
                          content: const Text(
                              '1. Click on the "Upload Photo" button to upload a photo of a Vietnamese traditional cake.\n\n2. The app will detect the cake and show the result.\n\n(VTCD can only recognize names of traditional Vietnamese cakes, not other objects like tables, chairs, etc.)'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Got it!',
                                style:
                                    TextStyle(color: Colors.deepPurpleAccent),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
                ),
              )
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => TestPage(),
              //       ),
              //     );
              //   },
              //   child: Text('How to use?'),
              // ),
            ],
          ),
        ),
      ],
    ));
  }
}

class HelpButton extends StatefulWidget {
  const HelpButton({super.key, required this.onHelpPressed});

  final void Function() onHelpPressed;

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  double _padding = 6;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onHelpPressed();
      },
      onTapDown: (_) {
        setState(() {
          _padding = 0;
        });
      },
      onTapCancel: () {
        setState(() {
          _padding = 6;
        });
      },
      onTapUp: (_) {
        setState(() {
          _padding = 6;
        });
      },
      child: AnimatedContainer(
        padding: EdgeInsets.only(bottom: _padding),
        margin: EdgeInsets.only(top: -(_padding - 6)),
        decoration: BoxDecoration(
          color:
              // widget.chosenAnswer.isEmpty ? Colors.grey[600] : Colors.blue[700],
              Colors.deepPurple,
          borderRadius: BorderRadius.circular(20),
        ),
        duration: Duration(milliseconds: 100),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            // color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
            color: Colors.deepPurpleAccent,
            border: Border.all(
              // color: widget.chosenAnswer.isEmpty ? Colors.grey : Colors.blue,
              color: Colors.deepPurpleAccent,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              'How to use this app?',
              style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

//////////////////// CLIP PATH ////////////////////

class CustomClipPathPurple extends CustomClipper<Path> {
  CustomClipPathPurple({required this.context});

  final BuildContext context;

  @override
  Path getClip(Size size) {
    // print(size);
    // double w = size.width;
    // double h = size.height;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.05);
    path.lineTo(w, h * 0.2);
    // path.quadraticBezierTo(w * 0.1, h * 0.12, w * 0.5, h * 0.08);
    // path.quadraticBezierTo(w * 0.8, h * 0.05, w, h * 0.11);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipPathPurpleAccent extends CustomClipper<Path> {
  CustomClipPathPurpleAccent({required this.context});

  final BuildContext context;

  @override
  Path getClip(Size size) {
    // print(size);
    // double w = size.width;
    // double h = size.height;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final path = Path();

    path.moveTo(0, 0);
    path.lineTo(0, h * 0.2);
    path.lineTo(w, h * 0.1);

    // path.quadraticBezierTo(w * 0.1, h * 0.1, w * 0.7, h * 0.12);
    // path.quadraticBezierTo(w * 1, h * 0.13, w, h * 0.08);
    path.lineTo(w, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
