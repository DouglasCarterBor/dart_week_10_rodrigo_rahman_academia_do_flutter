import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../../models/payment_type_model.dart';
import '../../../repositories/payment_type/payment_type_repository.dart';
part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  error,
  showAddOrUpdatePayment,
  saved,
}

class PaymentTypeController = PaymentTypeControllerBase with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {

final PaymentTypeRepository _paymentTypeRepository;

@readonly
var _status = PaymentTypeStateStatus.initial;

@readonly
var _paymentTypes = <PaymentTypeModel>[];

@readonly
String? _errorMessage;

@readonly
bool? _filterEnable; 

@readonly
PaymentTypeModel? _paymentTypeSelected;

PaymentTypeControllerBase(this._paymentTypeRepository);

@action
void changeFilter(bool? enabled) => _filterEnable = enabled;

void loadPayments() async {
    try {
    _status = PaymentTypeStateStatus.loading;
    _paymentTypes = await _paymentTypeRepository.findAll(_filterEnable);
    _status = PaymentTypeStateStatus.loaded;
  } on Exception catch (e, s) {
    log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
    _status = PaymentTypeStateStatus.error;
    _errorMessage = 'Erro ao buscar formas de pagamento';
  }
}

@action
 Future<void> addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    _status = PaymentTypeStateStatus.showAddOrUpdatePayment;
 }

 @action
 Future<void> editPayment(PaymentTypeModel paymentType) async {
      _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = paymentType;
    _status = PaymentTypeStateStatus.showAddOrUpdatePayment;
 }

 @action
 Future<void> savePayment({int? id, required String name, required String acronym, required bool enable,}) async {
    _status = PaymentTypeStateStatus.loading;
    final paymentTypeModel = PaymentTypeModel(id: id, name: name, acronym: acronym, enabled: enable,);
    await _paymentTypeRepository.save(paymentTypeModel);
    _status = PaymentTypeStateStatus.saved;
 }

}