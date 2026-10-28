import 'package:flutter/material.dart';

import '../services/database_service.dart';

class NewRepairScreen extends StatefulWidget {
  const NewRepairScreen({super.key});

  @override
  State<NewRepairScreen> createState() =>
      _NewRepairScreenState();
}

class _NewRepairScreenState
    extends State<NewRepairScreen> {

  final db = DatabaseService.instance;

  final customerController =
      TextEditingController();

  final phoneController =
      TextEditingController();

  final brandController =
      TextEditingController();

  final modelController =
      TextEditingController();

  final imeiController =
      TextEditingController();

  final problemController =
      TextEditingController();

  final costController =
      TextEditingController();

  final advanceController =
      TextEditingController();

  Widget input(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {

    return Padding(

      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: TextField(

        controller:
            controller,

        keyboardType:
            keyboardType,

        decoration:
            InputDecoration(
          labelText:
              label,

          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> saveRepair() async {

    if (customerController.text
            .trim()
            .isEmpty ||
        problemController.text
            .trim()
            .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Customer name and problem are required',
          ),
        ),
      );

      return;
    }

    await db.addRepair({

      'customerName':
          customerController.text.trim(),

      'phone':
          phoneController.text.trim(),

      'brand':
          brandController.text.trim(),

      'model':
          modelController.text.trim(),

      'imei':
          imeiController.text.trim(),

      'problem':
          problemController.text.trim(),

      'estimatedCost':
          double.tryParse(
                costController.text,
              ) ??
              0,

      'advancePaid':
          double.tryParse(
                advanceController.text,
              ) ??
              0,

      'status':
          'Received',

      'expectedDate':
          '',

      'createdAt':
          DateTime.now()
              .toIso8601String(),
    });

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text('New Repair'),
      ),

      body: ListView(

        padding:
            const EdgeInsets.all(16),

        children: [

          const Text(
            'Customer Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          input(
            'Customer Name *',
            customerController,
          ),

          input(
            'Phone Number',
            phoneController,
            keyboardType:
                TextInputType.phone,
          ),

          const SizedBox(height: 10),

          const Text(
            'Mobile Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          input(
            'Brand',
            brandController,
          ),

          input(
            'Model',
            modelController,
          ),

          input(
            'IMEI Number',
            imeiController,
          ),

          const SizedBox(height: 10),

          const Text(
            'Repair Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight:
                  FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          input(
            'Problem / Complaint *',
            problemController,
          ),

          input(
            'Estimated Repair Cost',
            costController,
            keyboardType:
                TextInputType.number,
          ),

          input(
            'Advance Paid',
            advanceController,
            keyboardType:
                TextInputType.number,
          ),

          const SizedBox(height: 15),

          SizedBox(

            height: 52,

            child: FilledButton.icon(

              onPressed:
                  saveRepair,

              icon:
                  const Icon(Icons.save),

              label:
                  const Text(
                'SAVE REPAIR',
              ),
            ),
          ),
        ],
      ),
    );
  }
}