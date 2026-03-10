import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData? icon;
  final String text;
  final VoidCallback onTap;
  final Color color;
  const ProfileMenuItem({
    this.icon,
    required this.text,
    required this.onTap,
    this.color = Colors.black87,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Row(
              children: <Widget>[
                Icon(icon, color: color),
                SizedBox(width: 13),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 18, color: color),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
