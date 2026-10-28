import 'package:flutter/material.dart';

import '../data/inventory_data.dart';

class AddNewStockScreen extends StatefulWidget {
  const AddNewStockScreen({super.key});

  @override
  State<AddNewStockScreen> createState() =>
      _AddNewStockScreenState();
}

class _AddNewStockScreenState
    extends State<AddNewStockScreen> {
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final ramController = TextEditingController();
  final storageController = TextEditingController();
  final colorController = TextEditingController();
  final purchasePriceController = TextEditingController();
  final sellingPriceController = TextEditingController();
  final stockController = TextEditingController();
  final minimumStockController = TextEditingController();

  @override
  void dispose() {
    brandController.dispose();
    modelController.dispose();
    ramController.dispose();
    storageController.dispose();
    colorController.dispose();
    purchasePriceController.dispose();
    sellingPriceController.dispose();
    stockController.dispose();
    minimumStockController.dispose();

    super.dispose();
  }

  void saveProduct() {
    if (brandController.text.trim().isEmpty ||
        modelController.text.trim().isEmpty ||
        purchasePriceController.text.trim().isEmpty ||
        sellingPriceController.text.trim().isEmpty ||
        stockController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
        ),
      );

      return;
    }

    final purchasePrice =
        double.tryParse(purchasePriceController.text);

    final sellingPrice =
        double.tryParse(sellingPriceController.text);

    final stock = int.tryParse(stockController.text);

    final minimumStock =
        int.tryParse(minimumStockController.text) ?? 2;

    if (purchasePrice == null ||
        sellingPrice == null ||
        stock == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid numbers'),
        ),
      );

      return;
    }

    InventoryData.addProduct(
      brand: brandController.text.trim(),
      model: modelController.text.trim(),
      ram: ramController.text.trim(),
      storage: storageController.text.trim(),
      color: colorController.text.trim(),
      purchasePrice: purchasePrice,
      sellingPrice: sellingPrice,
      stock: stock,
      minimumStock: minimumStock,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New stock added successfully'),
      ),
    );

    Navigator.pop(context);
  }

  Widget inputField(
    String label,
    TextEditingController controller, {
    bool number = false,
  }) {
    return TextField(
      controller: controller,
      keyboardType:
          number ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Stock'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            inputField('Brand *', brandController),

            const SizedBox(height: 15),

            inputField('Model *', modelController),

            const SizedBox(height: 15),

            inputField('RAM', ramController),

            const SizedBox(height: 15),

            inputField('Storage', storageController),

            const SizedBox(height: 15),

            inputField('Color', colorController),

            const SizedBox(height: 15),

            inputField(
              'Purchase Price *',
              purchasePriceController,
              number: true,
            ),

            const SizedBox(height: 15),

            inputField(
              'Selling Price *',
              sellingPriceController,
              number: true,
            ),

            const SizedBox(height: 15),

            inputField(
              'Stock Quantity *',
              stockController,
              number: true,
            ),

            const SizedBox(height: 15),

            inputField(
              'Minimum Stock Level',
              minimumStockController,
              number: true,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: saveProduct,
                icon: const Icon(Icons.add),
                label: const Text(
                  'ADD NEW STOCK',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}