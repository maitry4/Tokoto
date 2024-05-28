import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class CustomSearchBar extends StatefulWidget {
  CustomSearchBar({super.key});

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
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(2.sh()),
            ),
            hintText: 'Search Product',
            filled: true,
            fillColor: Theme.of(context).secondaryHeaderColor,
            prefixIcon: Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
