import 'package:flutter/material.dart';

import '../../../core/ui/widgets/base_header.dart';
import 'payment_type_controller.dart';

class PaymentTypeHeader extends StatefulWidget {

  final PaymentTypeController controller;

  const PaymentTypeHeader({ super.key, required this.controller });

  @override
  State<PaymentTypeHeader> createState() => _PaymentTypeHeaderState();
}

class _PaymentTypeHeaderState extends State<PaymentTypeHeader> {

  bool? enabled;

   @override
   Widget build(BuildContext context) {
       return BaseHeader(
        title: 'ADMINISTRAR FORMAS DE PAGAMENTO',
        buttonLabel: 'ADICIONAR',
        onPressed: (){
          widget.controller.addPayment();
        },
        onChanged: (_){},
        filterWidget: DropdownButton<bool>(
          value: enabled,
          items: const [
            DropdownMenuItem(value: null, child: Text('Todos'),),
            DropdownMenuItem(value: true, child: Text('Ativo'),),
            DropdownMenuItem(value: false, child: Text('Inativo'),),
          ],
          onChanged: (_){
            setState(() {
              enabled = _;
              widget.controller.changeFilter(_);
            });
           
          },
        ),
      
        );
  }
}