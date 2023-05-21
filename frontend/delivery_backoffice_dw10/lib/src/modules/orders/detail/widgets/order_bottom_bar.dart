import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dto/order/order_dto.dart';
import '../../../../models/orders/orders_status.dart';
import '../../order_controller.dart';

class OrderBottomBar extends StatelessWidget {


  final OrderDto order;
  final OrderController controller;

  const OrderBottomBar({ super.key, required this.order, required this.controller});

   @override
   Widget build(BuildContext context) {
       return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OrderBottomBarButton(
          borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          ),
          buttonColor: Colors.blue,
          buttonLabel: 'Finalizar',
          stringImage: 'assets/images/icons/finish_order_white_ico.png',
          onPressed: order.status == OrderStatus.confirmado ?(){
            controller.changeStatus(OrderStatus.finalizado);
          } : null, 
          ),
          OrderBottomBarButton(
          borderRadius: BorderRadius.zero,
          buttonColor: Colors.green,
          buttonLabel: 'Confirmar',
          stringImage: 'assets/images/icons/confirm_order_white_icon.png',
          onPressed: order.status == OrderStatus.pendente ? (){
            controller.changeStatus(OrderStatus.confirmado);
           } : null,
          ),
         OrderBottomBarButton(
          borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
          ),
          buttonColor: Colors.red,
          buttonLabel: 'Cancelar',
          stringImage: 'assets/images/icons/cancel_order_white_icon.png',
          onPressed: order.status != OrderStatus.cancelado && 
          order.status != OrderStatus.finalizado 
          ? (){
            controller.changeStatus(OrderStatus.cancelado);
          } : null,
          ),

        ],
       );
  }
}

class OrderBottomBarButton extends StatelessWidget {

 final BorderRadius borderRadius;
 final Color buttonColor;
 final String stringImage;
 final String buttonLabel;
 final VoidCallback? onPressed;


  const OrderBottomBarButton({super.key, required this.borderRadius, required this.buttonColor, required this.stringImage, required this.buttonLabel, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            backgroundColor: buttonColor,
            side: BorderSide(
              color: onPressed != null ? buttonColor : Colors.transparent,
            ),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(stringImage),
              const SizedBox(
                 width: 5,
              ),
              Text(
                buttonLabel,
                style: context.textStyles.textBold.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}