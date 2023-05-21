import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {

  final PaymentTypeController controller;
  final PaymentTypeModel? model;

  const PaymentTypeFormModal({ super.key, required this.model, required this.controller, });

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {

  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enable = false;

  @override
  void dispose() {
    nameEC.dispose();
    acronymEC.dispose();
    super.dispose();
  }

   void _closeModal() => Navigator.of(context).pop();

   @override
  void initState() {
    final paymentModel = widget.model;

    if(paymentModel != null){
      nameEC.text = paymentModel.name;
      acronymEC.text = paymentModel.acronym;
      enable = paymentModel.enabled;
    }

    super.initState();
  }

   @override
   Widget build(BuildContext context) {

    final screenWidth = context.screenWidth;

       return SingleChildScrollView(
        child: Container(
          width: screenWidth * (screenWidth > 1200 ? .5 : .7),
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text('${widget.model == null ? 'Cadastrar' : 'Editar'} forma de pagamento',
                        textAlign: TextAlign.center,
                        style: context.textStyles.textTitle,                      
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: _closeModal,
                          child: const Icon(Icons.close),
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                   height: 20,
                ),
                TextFormField(
                  validator: Validatorless.required('Nome obrigatório'),
                  controller: nameEC,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                ),     
                const SizedBox(
                   height: 20,
                ),
                TextFormField(
                  validator: Validatorless.required('Sigla obrigatória'),
                  controller: acronymEC,
                  decoration: const InputDecoration(
                    labelText: 'Sigla',
                  ),
                ),
                const SizedBox(
                   height: 20,
                ),
                Row(
                  children: [
                    Text('Ativo', style: context.textStyles.textRegular),
                    Switch(value: enable, onChanged: (_){
                      setState(() {
                        enable = _;
                      });                
                    },)
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 60,
                      child: OutlinedButton(
                        onPressed: _closeModal,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: Text('Cancelar', style: context.textStyles.textExtraBold
                        .copyWith(color: Colors.red,),),                        
                        ),),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.all(8),
                      child: ElevatedButton.icon(
                        onPressed: (){
                          final valid = formKey.currentState?.validate() ?? false;
                          if(valid){
                            final name = nameEC.text;
                            final acronym = acronymEC.text;
                            widget.controller.savePayment(
                              id: widget.model?.id,
                              name: name, 
                              acronym: acronym, 
                              enable: enable,
                              );
                          }
                        }, 
                        icon: const Icon(Icons.save), 
                        label: const Text('Salvar'),),
                    ),
                  ],
                ),
                
               ],
            ),
          ),
        ),
       );
  }
}