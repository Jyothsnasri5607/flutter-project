import 'package:flutter/material.dart';

import '../services/database_service.dart';
import 'new_repair_screen.dart';

class RepairsScreen extends StatefulWidget {
  const RepairsScreen({super.key});

  @override
  State<RepairsScreen> createState() =>
      _RepairsScreenState();
}

class _RepairsScreenState
    extends State<RepairsScreen> {

  final db = DatabaseService.instance;

  List<Map<String, dynamic>> repairs = [];

  @override
  void initState() {

    super.initState();

    loadRepairs();
  }

  Future<void> loadRepairs() async {

    repairs =
        await db.getRepairs();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> updateStatus(
    Map<String, dynamic> repair,
  ) async {

    final status =
        await showDialog<String>(

      context: context,

      builder: (_) {

        return SimpleDialog(

          title:
              const Text(
            'Update Repair Status',
          ),

          children: [

            'Received',
            'Diagnosing',
            'Repairing',
            'Ready for Delivery',
            'Delivered',

          ].map(
            (status) {

              return SimpleDialogOption(

                onPressed:
                    () => Navigator.pop(
                  context,
                  status,
                ),

                child:
                    Text(status),
              );
            },
          ).toList(),
        );
      },
    );

    if (status != null) {

      await db.updateRepairStatus(
        repair['id'],
        status,
      );

      loadRepairs();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title:
            const Text(
          'Mobile Repairs',
        ),
      ),

      floatingActionButton:
          FloatingActionButton.extended(

        onPressed: () async {

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const NewRepairScreen(),
            ),
          );

          loadRepairs();
        },

        icon:
            const Icon(Icons.build),

        label:
            const Text('New Repair'),
      ),

      body:

          repairs.isEmpty

              ? const Center(
                  child:
                      Text(
                    'No repair records',
                  ),
                )

              : ListView.builder(

                  padding:
                      const EdgeInsets.only(
                    bottom: 90,
                  ),

                  itemCount:
                      repairs.length,

                  itemBuilder:
                      (_, index) {

                    final repair =
                        repairs[index];

                    return Card(

                      margin:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),

                      child: ListTile(

                        leading:
                            const CircleAvatar(
                          child:
                              Icon(
                            Icons.phone_android,
                          ),
                        ),

                        title:
                            Text(
                          '${repair['brand']} '
                          '${repair['model']}',
                        ),

                        subtitle:
                            Text(
                          '${repair['customerName']}\n'
                          'Problem: ${repair['problem']}\n'
                          'Status: ${repair['status']}',
                        ),

                        isThreeLine:
                            true,

                        trailing:
                            IconButton(

                          onPressed:
                              () =>
                                  updateStatus(
                            repair,
                          ),

                          icon:
                              const Icon(
                            Icons.edit,
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}