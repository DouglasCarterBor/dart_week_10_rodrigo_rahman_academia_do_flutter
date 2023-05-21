import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/colors_app.dart';
import '../../core/ui/styles/text_styles.dart';
import 'login_controller.dart';


class LoginPage extends StatefulWidget {

  const LoginPage({ super.key });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with Loader, Messages{

  final emailEC = TextEditingController(text: 'rodrigorahman@academiadoflutter.com.br');
  final passwordEC = TextEditingController(text: '123123');
  final formKey = GlobalKey<FormState>();
  final controller = Modular.get<LoginController>();
  late final ReactionDisposer statusReactionDisposer;

  @override
  void initState() {
    statusReactionDisposer = reaction(
      (_) => controller.loginStatus,
      (status) {
        switch(status) {
          case LoginStateStatus.initial:
            break;
          case LoginStateStatus.loading:
            showLoader();
            break;
          case LoginStateStatus.success:
            hideLoader();
            Modular.to.navigate('/');
            break;
          case LoginStateStatus.error:
            hideLoader();
            showError(controller.errorMessage ?? 'Erro');
            break;
          
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    emailEC.dispose();
    passwordEC.dispose();
    statusReactionDisposer();
    super.dispose();
  }

  void _formSubmit() {
    final formValid = formKey.currentState?.validate() ?? false;                                        
      if(formValid){
        controller.login(emailEC.text, passwordEC.text);
    }
  }

   @override
   Widget build(BuildContext context) {

      final screenShortestSide = context.screenShortestSide;
      final screeWidth = context.screenWidth;

       return Scaffold(
           backgroundColor: context.blackColor,

           body: Form(
            key: formKey,
             child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: AlignmentDirectional.bottomCenter,
                  child: Container(
                    height: screenShortestSide * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/lanche.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: screenShortestSide * 0.5,
                  padding: EdgeInsets.only(top: context.percentHeight(0.1)),
                  child: Image.asset('assets/images/logo.png'),
                ),
           
                Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: context.percentWidth(screeWidth < 1300 ? .7 : .3),          
                      ),
                          decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                              ),
                               child: Padding(
                     padding: const EdgeInsets.all(30.0),
                     child: Column(
                       mainAxisSize: MainAxisSize.min,
                       children: [
                         FractionallySizedBox(
                          widthFactor: 0.3,
                          child: Image.asset('assets/images/logo.png'),),
                          const SizedBox(height: 20,),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('Login', style: context.textStyles.textTitle),),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: emailEC,
                            onFieldSubmitted: (_) => _formSubmit(),
                            decoration: const InputDecoration(                        
                              labelText: 'Email',                        
                            ),
                            validator: Validatorless.multiple([
                            Validatorless.required('E-mail obrigatório'),
                            Validatorless.email('E-mail inválido'),
                              ],),
                          ),
                          const SizedBox(height: 20,),
                          TextFormField(
                            controller: passwordEC,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Senha',                                                    
                            ),
                            validator: Validatorless.required('Senha obrigatória',),
                          ),
                          const SizedBox(height: 40,),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _formSubmit,
                              child: const Text('Entrar'),),),
                       ],
                      ),
                     ),   
                    ),
                  ),
                ),
           
           
              ],
             ),
           ),
       );
  }
}