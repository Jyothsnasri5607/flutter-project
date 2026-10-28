import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class LowStockScreen extends StatelessWidget {
  const LowStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lowStockProducts = InventoryData.products.where(
      (product) {
        return product['stock'] <= product['minimumStock'];
      },
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Low Stock'),
      ),
      body: lowStockProducts.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No Low Stock Items',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(18),
              itemCount: lowStockProducts.length,
              itemBuilder: (context, index) {
                final product = lowStockProducts[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.orange,
                      child: Icon(
                        Icons.warning,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      InventoryData.productName(product),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Minimum required: ${product['minimumStock']}',
                    ),
                    trailing: Text(
                      'Stock: ${product['stock']}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}