import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class AvailableStockScreen extends StatelessWidget {
  const AvailableStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Stock'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    const Icon(
                      Icons.inventory_2,
                      size: 55,
                      color: Colors.green,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      InventoryData.availableStock.toString(),
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Available Units',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: InventoryData.products.length,
                itemBuilder: (context, index) {
                  final product = InventoryData.products[index];

                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.phone_android,
                        color: Colors.green,
                      ),
                      title: Text(
                        InventoryData.productName(product),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Storage: ${product['storage']}',
                      ),
                      trailing: Text(
                        '${product['stock']} Units',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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