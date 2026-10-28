class InventoryData {
  static final List<Map<String, dynamic>> products = [
    {
      'id': 'P001',
      'brand': 'Apple',
      'model': 'iPhone 15',
      'ram': '6 GB',
      'storage': '128 GB',
      'color': 'Black',
      'purchasePrice': 50000.0,
      'sellingPrice': 55000.0,
      'stock': 5,
      'minimumStock': 2,
    },
    {
      'id': 'P002',
      'brand': 'Samsung',
      'model': 'Galaxy S24',
      'ram': '8 GB',
      'storage': '256 GB',
      'color': 'Blue',
      'purchasePrice': 55000.0,
      'sellingPrice': 62000.0,
      'stock': 3,
      'minimumStock': 2,
    },
    {
      'id': 'P003',
      'brand': 'OnePlus',
      'model': 'OnePlus 13',
      'ram': '12 GB',
      'storage': '256 GB',
      'color': 'Black',
      'purchasePrice': 42000.0,
      'sellingPrice': 48000.0,
      'stock': 2,
      'minimumStock': 3,
    },
  ];

  static int get totalProducts {
    return products.length;
  }

  static int get availableStock {
    int total = 0;

    for (var product in products) {
      total += product['stock'] as int;
    }

    return total;
  }

  static int get lowStock {
    int count = 0;

    for (var product in products) {
      if (product['stock'] <= product['minimumStock']) {
        count++;
      }
    }

    return count;
  }

  static void addProduct({
    required String brand,
    required String model,
    required String ram,
    required String storage,
    required String color,
    required double purchasePrice,
    required double sellingPrice,
    required int stock,
    required int minimumStock,
  }) {
    products.add({
      'id': 'P${products.length + 1}',
      'brand': brand,
      'model': model,
      'ram': ram,
      'storage': storage,
      'color': color,
      'purchasePrice': purchasePrice,
      'sellingPrice': sellingPrice,
      'stock': stock,
      'minimumStock': minimumStock,
    });
  }

  static String productName(Map<String, dynamic> product) {
    return '${product['brand']} ${product['model']}';
  }
}