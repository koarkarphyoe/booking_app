import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'package:student_app/data/vos/payment_method_vo.dart';
import 'package:student_app/persistence/hive_constants.dart';

class PaymentMethodDao {
  static final PaymentMethodDao _singleton = PaymentMethodDao._internal();
  factory PaymentMethodDao() {
    return _singleton;
  }
  PaymentMethodDao._internal();

  void saveAllPaymentMethod(List<PaymentMethodVO> paymentMehtodList) async {
    Map<int, PaymentMethodVO> paymentMethodMap = { for (var payment in paymentMehtodList) payment.id! : payment };
    await getPaymentMethodBox().putAll(paymentMethodMap);
  }

  List<PaymentMethodVO> getAllPaymentList() {
    return getPaymentMethodBox().values.toList();
  }

  //Reactive Programming
  Stream<List<PaymentMethodVO>> getAllPaymentListStream() {
    return getPaymentMethodBox()
        .watch()
        .map((event) => getAllPaymentList())
        .startWith(getAllPaymentList());
  }

  Box<PaymentMethodVO> getPaymentMethodBox() {
    return Hive.box<PaymentMethodVO>(boxNamePaymentMethodVO);
  }
}
