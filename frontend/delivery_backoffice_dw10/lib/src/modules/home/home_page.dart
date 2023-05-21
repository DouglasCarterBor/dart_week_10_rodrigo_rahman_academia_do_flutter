import 'package:flutter/material.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';

class HomePage extends StatefulWidget {

  const HomePage({ super.key });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messages {
   @override
   Widget build(BuildContext context) {
       return  Column(
         children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                validator: (string) => 'Erro',
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
              ),
            ),
          ),
           SizedBox(
            height: 50,
            width: 200,
             child: ElevatedButton(
              onPressed: (){},
              child:  const Text('Botão',),
             ),
           ),
         ],
       );
       
  }
}

