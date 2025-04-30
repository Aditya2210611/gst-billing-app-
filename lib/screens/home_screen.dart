import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';
import '../models/invoice_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<InvoiceItem> invoiceBox;

  List<InvoiceItem> invoiceItems = [];

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  double selectedGst = 5.0;

  @override
  void initState() {
    super.initState();
    invoiceBox = Hive.box<InvoiceItem>('invoices');
    loadInvoices();
  }

  void loadInvoices() {
    setState(() {
      invoiceItems = invoiceBox.values.toList();
    });
  }

  void addProduct() {
    final name = nameController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0;

    if (name.isEmpty || price <= 0) return;

    final product = Product(name: name, price: price, gstRate: selectedGst);
    final invoiceItem = InvoiceItem(product: product, quantity: 1);

    invoiceBox.add(invoiceItem);
    loadInvoices();

    nameController.clear();
    priceController.clear();
  }

  double get totalAmount => invoiceItems.fold(0, (sum, item) => sum + item.totalForQuantity);

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GST Billing')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Product Name'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
          ),
          DropdownButton<double>(
            value: selectedGst,
            items: [5, 12, 18, 28]
                .map((e) => DropdownMenuItem(
                      value: e.toDouble(),
                      child: Text('$e%'),
                    ))
                .toList(),
            onChanged: (val) => setState(() => selectedGst = val!),
          ),
          ElevatedButton(onPressed: addProduct, child: Text('Add Product')),
          SizedBox(height: 10),
          Expanded(
            child: invoiceItems.isEmpty
                ? Center(child: Text('No products added yet.'))
                : ListView.builder(
                    itemCount: invoiceItems.length,
                    itemBuilder: (context, index) {
                      final item = invoiceItems[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                            'Price: ₹${item.product.price.toStringAsFixed(2)} | '
                            'CGST: ₹${item.cgst.toStringAsFixed(2)}, SGST: ₹${item.sgst.toStringAsFixed(2)}',
                          ),
                          trailing: Text('₹${item.totalForQuantity.toStringAsFixed(2)}'),
                        ),
                      );
                    },
                  ),
          ),
          Divider(),
          Text(
            'Total: ₹${totalAmount.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ]),
      ),
    );
  }
}
