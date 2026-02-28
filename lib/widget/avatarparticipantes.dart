import 'package:flutter/material.dart';

class ParticipantsAvatars extends StatelessWidget {
  final List<String> names;
  final int maxVisible;

  const ParticipantsAvatars({
    super.key,
    required this.names,
    this.maxVisible = 3,
  });

  String _initials(String name) {
    final parts = name.split(" ");
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }

  Color _colorFromIndex(int index) {
    final colors = [
      Colors.blue.shade200,
      Colors.purple.shade200,
      Colors.teal.shade200,
      Colors.orange.shade200,
      Colors.green.shade200,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final visible = names.take(maxVisible).toList();
    final extra = names.length - visible.length;

    return SizedBox(
      height: 36,
      child: Stack(
        children: [
          for (int i = 0; i < visible.length; i++)
            Positioned(
              left: i * 28,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: _colorFromIndex(i),
                child: Text(
                  _initials(visible[i]),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),

          if (extra > 0)
            Positioned(
              left: visible.length * 28,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey.shade300,

                child: Text(
                  "+$extra",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
