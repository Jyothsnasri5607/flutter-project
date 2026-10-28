import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../services/database_service.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() =>
      _ReportsScreenState();
}

class _ReportsScreenState
    extends State<ReportsScreen> {

  final db = DatabaseService.instance;

  String selectedReport = 'Weekly';

  List<Map<String, dynamic>> sales = [];

  double totalSales = 0;

  @override
  void initState() {

    super.initState();

    loadReport();
  }

  Future<void> loadReport() async {

    final now = DateTime.now();

    DateTime from;
    DateTime to;

    if (selectedReport == 'Weekly') {

      final day =
          now.weekday;

      from = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(
        Duration(days: day - 1),
      );

      to = from.add(
        const Duration(days: 7),
      );

    } else {

      from = DateTime(
        now.year,
        now.month,
        1,
      );

      to = DateTime(
        now.year,
        now.month + 1,
        1,
      );
    }

    sales =
        await db.getSales(
      from: from,
      to: to,
    );

    totalSales =
        sales.fold(
      0,
      (sum, sale) =>
          sum +
          (sale['total'] as num)
              .toDouble(),
    );

    if (mounted) {
      setState(() {});
    }
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
            const Text('Sales Reports'),
      ),

      body: ListView(

        padding:
            const EdgeInsets.all(16),

        children: [

          Row(

            children: [

              Expanded(

                child: ChoiceChip(

                  label:
                      const Text(
                    'Weekly Sales',
                  ),

                  selected:
                      selectedReport ==
                          'Weekly',

                  onSelected: (_) {

                    setState(() {
                      selectedReport =
                          'Weekly';
                    });

                    loadReport();
                  },
                ),
              ),

              const SizedBox(width: 10),

              Expanded(

                child: ChoiceChip(

                  label:
                      const Text(
                    'Monthly Sales',
                  ),

                  selected:
                      selectedReport ==
                          'Monthly',

                  onSelected: (_) {

                    setState(() {
                      selectedReport =
                          'Monthly';
                    });

                    loadReport();
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          Card(

            child: Padding(

              padding:
                  const EdgeInsets.all(25),

              child: Column(

                children: [

                  Text(
                    '$selectedReport Sales',
                    style:
                        const TextStyle(
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    money.format(
                      totalSales,
                    ),

                    style:
                        const TextStyle(
                      fontSize: 32,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '${sales.length} transactions',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'Sales History',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          if (sales.isEmpty)

            const Center(
              child:
                  Padding(
                padding:
                    EdgeInsets.all(30),
                child:
                    Text(
                  'No sales during this period',
                ),
              ),
            )

          else

            ...sales.map(
              (sale) {

                return Card(

                  child: ListTile(

                    leading:
                        const CircleAvatar(
                      child:
                          Icon(
                        Icons.receipt_long,
                      ),
                    ),

                    title:
                        Text(
                      sale['productName'],
                    ),

                    subtitle:
                        Text(
                      'Quantity: ${sale['quantity']}\n'
                      'Payment: ${sale['paymentMethod']}',
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
        ],
      ),
    );
  }
}