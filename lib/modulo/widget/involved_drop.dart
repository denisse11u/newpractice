import 'package:aplicacionflutter/model/view_flows_response.dart';
import 'package:flutter/material.dart';

class InvolvedDropdown extends StatefulWidget {
  final List<Involved> involveds;
  final Function(Involved?) onChanged;

  const InvolvedDropdown({
    super.key,
    required this.involveds,
    required this.onChanged,
  });

  @override
  State<InvolvedDropdown> createState() => _InvolvedDropdownState();
}

class _InvolvedDropdownState extends State<InvolvedDropdown> {
  Involved? selected;

  @override
  void initState() {
    super.initState();
    if (widget.involveds.isNotEmpty) {
      selected = widget.involveds.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Involved>(
      value: selected,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),

      items: widget.involveds.map((inv) {
        final user = inv.user;

        final label =
            "${user?.firstName ?? ''} ${user?.lastName ?? ''} - ${user?.identification ?? ''}";
        return DropdownMenuItem(value: inv, child: Text(label));
      }).toList(),

      onChanged: (value) {
        setState(() {
          selected = value;
        });

        widget.onChanged(value);
      },
    );
  }
}
