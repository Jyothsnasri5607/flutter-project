import 'package:flutter/material.dart';
import '../services/database_service.dart';

class ProductFormScreen extends StatefulWidget {
  final Map<String, dynamic>? product;

  const ProductFormScreen({
    super.key,
    this.product,
  });

  @override
  State<ProductFormScreen> createState() =>
      _ProductFormScreenState();
}

class _ProductFormScreenState
    extends State<ProductFormScreen> {

  final db = DatabaseService.instance;

  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final imeiController = TextEditingController();
  final purchaseController = TextEditingController();
  final sellingController = TextEditingController();
  final stockController = TextEditingController();
  final minimumStockController =
      TextEditingController(text: '1');
  final supplierController = TextEditingController();
  final warrantyController = TextEditingController();

  bool get isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    if (product != null) {

      nameController.text =
          product['name'] ?? '';

      categoryController.text =
          product['category'] ?? '';

      brandController.text =
          product['brand'] ?? '';

      modelController.text =
          product['model'] ?? '';

      imeiController.text =
          product['imei'] ?? '';

      purchaseController.text =
          '${product['purchasePrice'] ?? 0}';

      sellingController.text =
          '${product['sellingPrice'] ?? 0}';

      stockController.text =
          '${product['stock'] ?? 0}';

      minimumStockController.text =
          '${product['minStock'] ?? 1}';

      supplierController.text =
          product['supplier'] ?? '';

      warrantyController.text =
          product['warranty'] ?? '';
    }
  }

  @override
  void dispose() {

    nameController.dispose();
    categoryController.dispose();
    brandController.dispose();
    modelController.dispose();
    imeiController.dispose();
    purchaseController.dispose();
    sellingController.dispose();
    stockController.dispose();
    minimumStockController.dispose();
    supplierController.dispose();
    warrantyController.dispose();

    super.dispose();
  }

  Widget inputField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    bool required = false,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(bottom: 14),

      child: TextField(

        controller: controller,

        keyboardType: keyboardType,

        decoration:
            InputDecoration(

          labelText:
              required
                  ? '$label *'
                  : label,

          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> saveProduct() async {

    if (nameController.text
            .trim()
            .isEmpty ||
        categoryController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Product name and category are required',
          ),
        ),
      );

      return;
    }

    final product = {

      'name':
          nameController.text.trim(),

      'category':
          categoryController.text.trim(),

      'brand':
          brandController.text.trim(),

      'model':
          modelController.text.trim(),

      'imei':
          imeiController.text.trim(),

      'purchasePrice':
          double.tryParse(
                purchaseController.text,
              ) ??
              0,

      'sellingPrice':
          double.tryParse(
                sellingController.text,
              ) ??
              0,

      'stock':
          int.tryParse(
                stockController.text,
              ) ??
              0,

      'minStock':
          int.tryParse(
                minimumStockController.text,
              ) ??
              1,

      'supplier':
          supplierController.text.trim(),

      'warranty':
          warrantyController.text.trim(),

      'createdAt':
          widget.product?['createdAt'] ??
              DateTime.now()
                  .toIso8601String(),
    };

    if (isEditing) {

      await db.updateProduct(
        widget.product!['id'],
        product,
      );

    } else {

      await db.addProduct(product);
    }

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: Text(
          isEditing
              ? 'Edit Product'
              : 'Add Product',
        ),
      ),

      body: ListView(

        padding:
            const EdgeInsets.all(16),

        children: [

          const Text(
            'Product Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          inputField(
            'Product Name',
            nameController,
            required: true,
          ),

          inputField(
            'Category',
            categoryController,
            required: true,
          ),

          inputField(
            'Brand',
            brandController,
          ),

          inputField(
            'Model',
            modelController,
          ),

          inputField(
            'IMEI / Serial Number',
            imeiController,
          ),

          const SizedBox(height: 10),

          const Text(
            'Price & Stock',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          inputField(
            'Purchase Price',
            purchaseController,
            keyboardType:
                TextInputType.number,
          ),

          inputField(
            'Selling Price',
            sellingController,
            keyboardType:
                TextInputType.number,
          ),

          inputField(
            'Current Stock',
            stockController,
            keyboardType:
                TextInputType.number,
          ),

          inputField(
            'Minimum Stock Alert',
            minimumStockController,
            keyboardType:
                TextInputType.number,
          ),

          const SizedBox(height: 10),

          const Text(
            'Additional Information',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          inputField(
            'Supplier',
            supplierController,
          ),

          inputField(
            'Warranty',
            warrantyController,
          ),

          const SizedBox(height: 15),

          SizedBox(

            height: 52,

            child: FilledButton.icon(

              onPressed:
                  saveProduct,

              icon:
                  const Icon(Icons.save),

              label: Text(
                isEditing
                    ? 'UPDATE PRODUCT'
                    : 'SAVE PRODUCT',
              ),
            ),
          ),
        ],
      ),
    );
  }
}