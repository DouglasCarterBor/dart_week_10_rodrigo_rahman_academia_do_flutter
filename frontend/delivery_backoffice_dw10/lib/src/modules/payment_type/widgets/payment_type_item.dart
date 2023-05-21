import 'package:flutter/material.dart';

import '../../../core/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import 'payment_type_controller.dart';

class PaymentTypeItem extends StatelessWidget {

  final PaymentTypeController controller;
  final PaymentTypeModel paymentType;

  const PaymentTypeItem({ super.key, required this.paymentType, required this.controller });

   @override
   Widget build(BuildContext context) {

      final colorEnableAll = paymentType.enabled ? Colors.black : Colors.grey;

       return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),          
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Image.asset('assets/images/icons/payment_${paymentType.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace){
                return Image.asset('assets/images/icons/payment_notfound_icon.png',
                color: colorEnableAll,
                );
              },
             color: colorEnableAll,
              ),
              const SizedBox(
                 width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text('Forma de pagamento',
                      style: context.textStyles.textRegular.copyWith(color: colorEnableAll),
                      ),
                    ),
                    const SizedBox(
                       height: 20,
                    ),
                    FittedBox(
                      child: Text(paymentType.name,
                      style: context.textStyles.textTitle.copyWith(color: colorEnableAll),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: (){
                      controller.editPayment(paymentType);
                    },
                    child: Text(
                      'Editar',
                      style: context.textStyles.textMedium.copyWith(color: paymentType.enabled ? Colors.green : colorEnableAll),
                    
                    ),
                    ),
                ),
              ),
            ],
          ),
        ),);
  }
}