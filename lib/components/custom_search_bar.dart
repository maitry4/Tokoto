import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CustomSearchBar extends StatefulWidget {
  void Function(String)? onChanged;
  CustomSearchBar({super.key, required this.onChanged});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:1.sw(),
      child: Padding(
        padding: EdgeInsets.only(left: 4.sw(), right: 4.sw(),  top: 2.sh()),
        child: TextField(
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(2.sh()),
            ),
            hintText: 'Search Product'.tr,
            filled: true,
            fillColor: Theme.of(context).secondaryHeaderColor,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
