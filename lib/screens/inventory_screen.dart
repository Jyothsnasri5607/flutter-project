import 'package:flutter/material.dart';

import '../data/inventory_data.dart';
import 'total_products_screen.dart';
import 'available_stock_screen.dart';
import 'low_stock_screen.dart';
import 'product_list_screen.dart';
import 'add_new_stock_screen.dart';
import 'stock_quantity_screen.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Inventory',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Inventory Management',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Manage products, stock and restocking',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // 1. TOTAL PRODUCTS
            buildMenuCard(
              context,
              title: 'Total Products',
              subtitle: 'View all products available in the shop',
              value: InventoryData.totalProducts.toString(),
              icon: Icons.phone_android,
              iconColor: Colors.blue,
              page: const TotalProductsScreen(),
            ),

            // 2. AVAILABLE STOCK
            buildMenuCard(
              context,
              title: 'Available Stock',
              subtitle: 'View total available mobile units',
              value: InventoryData.availableStock.toString(),
              icon: Icons.inventory_2,
              iconColor: Colors.green,
              page: const AvailableStockScreen(),
            ),

            // 3. LOW STOCK
            buildMenuCard(
              context,
              title: 'Low Stock',
              subtitle: 'View products that need restocking',
              value: InventoryData.lowStock.toString(),
              icon: Icons.warning,
              iconColor: Colors.orange,
              page: const LowStockScreen(),
            ),

            // 4. PRODUCT LIST
            buildMenuCard(
              context,
              title: 'Product List',
              subtitle: 'View complete product details',
              value: '',
              icon: Icons.list_alt,
              iconColor: Colors.purple,
              page: const ProductListScreen(),
            ),

            // 5. ADD NEW STOCK
            buildMenuCard(
              context,
              title: 'Add New Stock',
              subtitle: 'Add a new mobile to your inventory',
              value: '',
              icon: Icons.add_box,
              iconColor: Colors.teal,
              page: const AddNewStockScreen(),
            ),

            // 6. STOCK QUANTITY
            buildMenuCard(
              context,
              title: 'Stock Quantity',
              subtitle: 'Check quantity of every mobile',
              value: '${InventoryData.availableStock} Units',
              icon: Icons.storage,
              iconColor: Colors.indigo,
              page: const StockQuantityScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Widget page,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,

      child: Card(
        elevation: 2,
        color: Colors.white,

        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );
          },

          child: Padding(
            padding: const EdgeInsets.all(18),

            child: Row(
              children: [
                // ICON
                Container(
                  width: 55,
                  height: 55,

                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 18),

                // TITLE + SUBTITLE
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),

                // VALUE
                if (value.isNotEmpty)
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 15),

                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: iconColor,
                      ),
                    ),
                  ),

                // ARROW
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 17,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}