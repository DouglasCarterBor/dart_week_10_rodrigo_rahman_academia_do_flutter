
import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import 'menu/menu_bar.dart' as menu;

class BaseLayout extends StatelessWidget {

  final Widget body;

  const BaseLayout({ required this.body, super.key });

   @override
   Widget build(BuildContext context) {

    final screenWidth = context.screenWidth;
    final shortestSide = context.screenShortestSide;

       return Scaffold(
           body: SizedBox(
             height: context.screenHeight,
             child: Stack(
              children: [
                Container(
                  color: Colors.black,
                  constraints: BoxConstraints(
                    minWidth: screenWidth,
                    minHeight: shortestSide * .18,
                    maxHeight: shortestSide * .18,
                  ),
                  alignment: Alignment.centerLeft,            
                  child: Container(
                    width: shortestSide * .13,                   
                      margin: const EdgeInsets.only(left: 60),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    ),
                ),
                Positioned.fill(
                  top: shortestSide * .13,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(10),
                        right: Radius.circular(10),
                      ),    
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const menu.MenuBar(),
                        const SizedBox(
                           height: 10,
                        ),
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                              color: const Color(0xffE5E5E5),    
                              borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(10),
                              ),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                                                   
                            child: body,
                            ),
                        ),
                      ],
                    ),
                  ),
                  ),
              ],
             ),
           ),
       );
  }
}