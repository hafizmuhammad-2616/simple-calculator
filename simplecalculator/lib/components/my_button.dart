import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final Color clr;
  final Color? txtclr;
  final VoidCallback onpressed;
  const MyButton({
    super.key,
    required this.text,
    this.clr = const Color(0xffa5a5a5),
    required this.onpressed,
    this.txtclr = Colors.white,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  Color? _currentColor;
  late Color _hoverColor;

  @override
  void initState() {
    super.initState();
    _currentColor = widget.clr;
    if (widget.clr == const Color(0xffffa00a)) {
      // Orange button hover
      _hoverColor = const Color.fromARGB(237, 255, 153, 0);
    } else {
      // Grey button hover
      _hoverColor = const Color.fromARGB(255, 147, 141, 141);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * (4.5 / 360),
        ),
        child: MouseRegion(
          onEnter: (_) {
            setState(() {
              _currentColor = _hoverColor;
            });
          },
          onExit: (_) {
            setState(() {
              _currentColor = widget.clr; // original color
            });
          },
          child: GestureDetector(
            onTap: widget.onpressed,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.09,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentColor,
              ),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    color: widget.txtclr,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
