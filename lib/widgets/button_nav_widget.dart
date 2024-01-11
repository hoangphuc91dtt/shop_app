import 'package:flutter/material.dart';
import '../themes/colors.dart';

class ButtonNav extends StatefulWidget {
  const ButtonNav({required this.name, required this.isActive, required this.onPressed});
  final String name;
  final bool isActive;
  final VoidCallback onPressed;

  @override
  State<ButtonNav> createState() => _ButtonNavState();
}

class _ButtonNavState extends State<ButtonNav> {
  late bool _isActiveBtn;

  @override
  void initState() {
    super.initState();
    _isActiveBtn = false;
  }

  void setActive(bool isActive) {
    setState(() {
      isActive = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 90,
      decoration: BoxDecoration(
        color: widget.isActive ? AppColor.primaryColor : Color(0xffF3F4F6),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Đặt border radius
            ),
          ),
        ),
        child: Text(
          '${widget.name}',
          style: TextStyle(
            color: widget.isActive ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
