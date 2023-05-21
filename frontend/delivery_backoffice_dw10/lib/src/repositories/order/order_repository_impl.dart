import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/exceptions/repository_exception.dart';
import '../../core/rest_client/custom_dio.dart';
import '../../models/orders/orders_status.dart';
import '../../modules/orders/order_model.dart';
import './order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {

  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);

  @override
  Future<void> changeStatus(int id, OrderStatus status) async {
    try {
      await _dio.auth().put('/orders/$id', data: {'status': status.acronym});	
    } on DioError catch (e, s) {
      log('Erro ao alterar status do pedido $id: $e', error: e.message, stackTrace: s);
      throw RepositoryException(message: 'Erro ao alterar status do pedido ${status.acronym}');
    }
  }

  @override
  Future<List<OrderModel>> findAllOrders(
    DateTime date, 
    [OrderStatus? status,]) 
    async {
       try {
      final orderResponse = await _dio.auth().get(
        '/orders',
         queryParameters: {
          'date': date.toIso8601String(),
        if(status != null) 'status' : status.acronym,
         },
        );
        if(orderResponse.data.isNotEmpty){
          return await orderResponse.data.map<OrderModel>((o)=> OrderModel.fromMap(o)).toList();
        } else {
          return [];
        }
    } on DioError catch (e, s) {
      log('Erro ao buscar pedidos', error: e.message, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar pedidos');
    }
  }

  @override
  Future<OrderModel> getById(int id) async {
        try {
      final orderResponse = await _dio.auth().get(
        '/orders/$id',
        );
        return OrderModel.fromMap(orderResponse.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar pedido', error: e.message, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar pedido');
    }
  }

}