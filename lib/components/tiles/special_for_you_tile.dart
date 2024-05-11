import 'package:flutter/material.dart';
import 'package:tokoto/components/sub_components/special_for_you_subtile.dart';

class Special4UTile extends StatelessWidget {
  const Special4UTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Spe4USub(category: "Smartphone", brands: "18 Brands", image_path: "assets/gadget.jpg",),
          Spe4USub(category: "Fashion", brands: "24 Brands", image_path: "assets/fashion.jpg",),
        ],
      ),
    );
  }
}