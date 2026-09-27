import 'package:flutter/material.dart';

class MyCardWidget extends StatelessWidget {
  final Color color;
  final double elevations;
  final String title;
  final String subtitle;
  final IconData icons;

  const MyCardWidget({
    super.key,
    required this.color,
    required this.elevations,
    required this.title,
    required this.icons,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevations,
      color: color.withValues(alpha: 0.05),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: color.withValues(alpha: 0.05), width: 1.5),
      ),

      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Icon(icons, color: color, size: 36),
          title: Text(
            "Account Summary",

            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: Text(
              "Standard shadowm{elevation 4.0}, for main content block.",
            ),
          ),
        ),
      ),
    );
  }
}
