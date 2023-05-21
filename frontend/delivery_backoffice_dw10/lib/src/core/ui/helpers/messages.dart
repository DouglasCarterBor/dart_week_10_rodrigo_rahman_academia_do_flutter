import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

mixin Messages<T extends StatefulWidget> on State<T> {

  void showError(String massage){
    _showSnackBar( AwesomeSnackbarContent(
      title: 'Erro',
      message: massage,
      contentType: ContentType.failure,      
      ),
    );
  }
  void showWarning(String massage){
    _showSnackBar( AwesomeSnackbarContent(
      title: 'Atenção',
      message: massage,
      contentType: ContentType.warning,
    ),);
  }
  void showInfo(String massage){
    _showSnackBar( AwesomeSnackbarContent(
      title: 'Atenção',
      message: massage,
      contentType: ContentType.help,
     ),
    );
  }
  void showSuccess(String massage){
    _showSnackBar( AwesomeSnackbarContent(
      title: 'Sucesso',
      message: massage,
      contentType: ContentType.success,
     ),
    );
  }

  void _showSnackBar(AwesomeSnackbarContent content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.only(top: 72),
        content: content,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  }