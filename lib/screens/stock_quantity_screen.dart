import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class StockQuantityScreen extends StatelessWidget {
  const StockQuantityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Quantity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Card(
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.inventory,
                      size: 40,
                      color: Colors.indigo,
                    ),

                    const SizedBox(width: 15),

                    const Expanded(
                      child: Text(
                        'Total Available Units',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),

                    Text(
                      InventoryData.availableStock.toString(),
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: ListView.builder(
                itemCount: InventoryData.products.length,
                itemBuilder: (context, index) {
                  final product = InventoryData.products[index];

                  final int stock = product['stock'];

                  final bool low =
                      stock <= product['minimumStock'];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone_android,
                        color:
                            low ? Colors.red : Colors.green,
                      ),

                      title: Text(
                        InventoryData.productName(product),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        'Minimum: ${product['minimumStock']} units',
                      ),

                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: low
                              ? Colors.red.shade50
                              : Colors.green.shade50,
                          borderRadius:
                              BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$stock Units',
                          style: TextStyle(
                            color: low
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}