import 'package:flutter/material.dart';
import 'package:tokoto/responsive/responsive_extension.dart';

class ExploreTilePurple extends StatelessWidget {
  const ExploreTilePurple({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: EdgeInsets.all(2.sh()),
                child: Container(
                  padding: EdgeInsets.only(top: 3.sh(), bottom: 3.sh(),right: 41.sw(), left: 5.sw()),
                  decoration: BoxDecoration(
                  color: Color.fromARGB(255, 83, 61, 156),
                  borderRadius: BorderRadius.circular(2.sh()),
                  ),
                  child:Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Text(
                        "A Summer Surprise", 
                        style: TextStyle(color: Colors.white,)
                      ),
                      Text(
                        "Cashback 20%", 
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:3.sh(),
                          fontWeight: FontWeight.bold,
                          )
                        ),
                    ],
                  ),
                ),
              );
  }
}