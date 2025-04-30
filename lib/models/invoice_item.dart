import 'package:hive/hive.dart';
import 'product.dart';

part 'invoice_item.g.dart';

@HiveType(typeId: 1)
class InvoiceItem extends HiveObject {
  @HiveField(0)
  Product product;

  @HiveField(1)
  int quantity;

  InvoiceItem({required this.product, required this.quantity});

  double get cgst => (product.price * product.gstRate / 100) / 2;
  double get sgst => (product.price * product.gstRate / 100) / 2;
  double get total => product.price + cgst + sgst;
  double get totalForQuantity => total * quantity;
}
