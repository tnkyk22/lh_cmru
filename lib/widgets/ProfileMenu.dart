import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.amber.withOpacity(0.7),
        ),
        child: Icon(icon, color: const Color(0xFF262626)),
      ),
      title: Text(
        title,
        style: GoogleFonts.urbanist(
          color: textColor ?? Colors.grey[700],
          fontWeight: title == 'SIGN OUT' ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[100],
              ),
              child:  Icon(Icons.double_arrow_rounded, size: 18, color: Colors.grey[400]),
            )
          : null, // ไม่แสดง icon หาก endIcon เป็น false
    );
  }
}
