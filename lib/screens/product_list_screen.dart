import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: InventoryData.products.length,
        itemBuilder: (context, index) {
          final product = InventoryData.products[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 15),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.phone_android),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          InventoryData.productName(product),
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Text(
                        '₹${product['sellingPrice'].toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const Divider(height: 25),

                  detailRow('RAM', product['ram'].toString()),
                  detailRow(
                    'Storage',
                    product['storage'].toString(),
                  ),
                  detailRow(
                    'Color',
                    product['color'].toString(),
                  ),
                  detailRow(
                    'Purchase Price',
                    '₹${product['purchasePrice'].toStringAsFixed(0)}',
                  ),
                  detailRow(
                    'Selling Price',
                    '₹${product['sellingPrice'].toStringAsFixed(0)}',
                  ),
                  detailRow(
                    'Stock',
                    '${product['stock']} Units',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget detailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}