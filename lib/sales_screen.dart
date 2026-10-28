import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/database_service.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() =>
      _SalesScreenState();
}

class _SalesScreenState
    extends State<SalesScreen> {

  final db = DatabaseService.instance;

  List<Map<String, dynamic>> sales = [];

  List<Map<String, dynamic>> products = [];

  @override
  void initState() {

    super.initState();

    loadData();
  }

  Future<void> loadData() async {

    sales =
        await db.getSales();

    products =
        await db.getProducts();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> createSale() async {

    final availableProducts =
        products
            .where(
              (product) =>
                  product['stock'] > 0,
            )
            .toList();

    if (availableProducts.isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('No products are in stock'),
        ),
      );

      return;
    }

    Map<String, dynamic>? selectedProduct;

    final quantityController =
        TextEditingController(
      text: '1',
    );

    final customerController =
        TextEditingController();

    String paymentMethod = 'Cash';

    await showDialog(

      context: context,

      builder: (dialogContext) {

        return StatefulBuilder(

          builder:
              (context, setDialogState) {

            return AlertDialog(

              title:
                  const Text('New Sale'),

              content: SizedBox(

                width: 450,

                child: SingleChildScrollView(

                  child: Column(

                    children: [

                      DropdownButtonFormField<
                          Map<String, dynamic>>(
                        decoration:
                            const InputDecoration(
                          labelText:
                              'Select Product',
                          border:
                              OutlineInputBorder(),
                        ),

                        items:
                            availableProducts
                                .map(
                          (product) {

                            return DropdownMenuItem<
                                Map<String, dynamic>>(
                              value:
                                  product,

                              child:
                                  Text(
                                '${product['name']} '
                                '(Stock: ${product['stock']})',
                              ),
                            );
                          },
                        ).toList(),

                        onChanged:
                            (value) {

                          setDialogState(() {

                            selectedProduct =
                                value;
                          });
                        },
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      TextField(

                        controller:
                            quantityController,

                        keyboardType:
                            TextInputType.number,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Quantity',
                          border:
                              OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      TextField(

                        controller:
                            customerController,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Customer Name',
                          border:
                              OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(
                        height: 14,
                      ),

                      DropdownButtonFormField<
                          String>(

                        value:
                            paymentMethod,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Payment Method',
                          border:
                              OutlineInputBorder(),
                        ),

                        items: [

                          'Cash',
                          'UPI',
                          'Card',
                          'Credit',

                        ].map(
                          (method) {

                            return DropdownMenuItem(
                              value:
                                  method,

                              child:
                                  Text(method),
                            );
                          },
                        ).toList(),

                        onChanged:
                            (value) {

                          setDialogState(() {

                            paymentMethod =
                                value ??
                                    'Cash';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              actions: [

                TextButton(

                  onPressed:
                      () => Navigator.pop(
                    dialogContext,
                  ),

                  child:
                      const Text('CANCEL'),
                ),

                FilledButton(

                  onPressed:
                      selectedProduct ==
                              null
                          ? null
                          : () async {

                              final quantity =
                                  int.tryParse(
                                quantityController
                                    .text,
                              ) ??
                                      0;

                              if (quantity <=
                                  0) {

                                return;
                              }

                              if (quantity >
                                  selectedProduct![
                                      'stock']) {

                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Not enough stock',
                                    ),
                                  ),
                                );

                                return;
                              }

                              final price =
                                  (selectedProduct![
                                              'sellingPrice']
                                          as num)
                                      .toDouble();

                              final total =
                                  price *
                                      quantity;

                              try {

                                await db
                                    .recordSale(

                                  productId:
                                      selectedProduct![
                                          'id'],

                                  productName:
                                      selectedProduct![
                                          'name'],

                                  quantity:
                                      quantity,

                                  total:
                                      total,

                                  customerName:
                                      customerController
                                          .text
                                          .trim(),

                                  paymentMethod:
                                      paymentMethod,
                                );

                                if (!mounted) {
                                  return;
                                }

                                Navigator.pop(
                                  dialogContext,
                                );

                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Sale recorded and stock updated successfully',
                                    ),
                                  ),
                                );

                              } catch (e) {

                                ScaffoldMessenger
                                    .of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content:
                                        Text(
                                      e.toString(),
                                    ),
                                  ),
                                );
                              }
                            },

                  child:
                      const Text(
                    'CONFIRM SALE',
                  ),
                ),
              ],
            );
          },
        );
      },
    );

    loadData();
  }

  @override
  Widget build(BuildContext context) {

    final money =
        NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0,
    );

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('Sales'),
      ),

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed:
            createSale,

        icon:
            const Icon(
          Icons.add_shopping_cart,
        ),

        label:
            const Text('New Sale'),
      ),

      body:

          sales.isEmpty

              ? const Center(
                  child:
                      Text(
                    'No sales recorded',
                  ),
                )

              : ListView.builder(

                  padding:
                      const EdgeInsets.only(
                    bottom: 90,
                  ),

                  itemCount:
                      sales.length,

                  itemBuilder:
                      (_, index) {

                    final sale =
                        sales[index];

                    return Card(

                      margin:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),

                      child: ListTile(

                        leading:
                            const CircleAvatar(
                          child:
                              Icon(
                            Icons.receipt,
                          ),
                        ),

                        title:
                            Text(
                          sale['productName'],
                        ),

                        subtitle:
                            Text(
                          'Quantity: ${sale['quantity']}\n'
                          'Payment: ${sale['paymentMethod']}\n'
                          'Customer: ${sale['customerName'] ?? 'Walk-in'}',
                        ),

                        isThreeLine:
                            true,

                        trailing:
                            Text(
                          money.format(
                            sale['total'],
                          ),

                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}