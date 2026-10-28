import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class TotalProductsScreen extends StatelessWidget {
  const TotalProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Total Products'),
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
                      Icons.phone_android,
                      size: 55,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      InventoryData.totalProducts.toString(),
                      style: const TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Total Products',
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
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(
                        InventoryData.productName(product),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${product['ram']} • ${product['storage']} • ${product['color']}',
                      ),
                      trailing: Text(
                        '₹${product['sellingPrice'].toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
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