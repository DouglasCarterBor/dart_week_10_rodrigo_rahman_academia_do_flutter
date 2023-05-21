import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var isOpen = false;

  void showLoader() {
    if(!isOpen) {
      isOpen = true;
      showDialog(
        /// Proibir que ele seja descartado
        barrierDismissible: false,
        context: context, 
        builder: (context) {
          return LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: 40,
            );
        },
        );
    }
    
  }

  void hideLoader() {
    if(isOpen){
      isOpen = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  void dispose() {
    hideLoader();
    super.dispose();
  }

}
