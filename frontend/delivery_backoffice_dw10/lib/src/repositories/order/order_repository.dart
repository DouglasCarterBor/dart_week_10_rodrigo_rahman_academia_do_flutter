import '../../models/orders/orders_status.dart';
import '../../modules/orders/order_model.dart';

abstract class OrderRepository {
   Future<List<OrderModel>> findAllOrders(DateTime date, [OrderStatus? status]);
   Future<OrderModel> getById(int id);
   Future<void> changeStatus(int id, OrderStatus status);
}

