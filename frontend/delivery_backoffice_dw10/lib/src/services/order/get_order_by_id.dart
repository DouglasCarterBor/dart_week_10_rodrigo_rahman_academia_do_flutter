import '../../dto/order/order_dto.dart';
import '../../modules/orders/order_model.dart';

abstract class GetOrderById {
  Future<OrderDto> call(OrderModel order);
}