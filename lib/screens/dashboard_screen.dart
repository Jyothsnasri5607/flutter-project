import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cell Point Dashboard'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Welcome, Owner 👋',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Manage your mobile shop easily',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 25),

            // INVENTORY
            dashboardCard(
              context,
              title: 'Inventory',
              subtitle:
                  'Manage products, stock and restocking',
              icon: Icons.inventory_2,
              page: const InventoryScreen(),
            ),

            // SALES
            dashboardCard(
              context,
              title: 'Sales',
              subtitle:
                  'Record sales and update stock',
              icon: Icons.point_of_sale,
              page: const SalesScreen(),
            ),

            // REPAIRS
            dashboardCard(
              context,
              title: 'Mobile Repairs',
              subtitle:
                  'Manage customer mobile repairs',
              icon: Icons.build,
              page: const RepairsScreen(),
            ),

            // REPORTS
            dashboardCard(
              context,
              title: 'Sales Reports',
              subtitle:
                  'Check daily, weekly and monthly sales',
              icon: Icons.bar_chart,
              page: const ReportsScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget dashboardCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 3,

      child: ListTile(
        contentPadding: const EdgeInsets.all(16),

        leading: CircleAvatar(
          radius: 28,
          child: Icon(
            icon,
            size: 28,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => page,
            ),
          );
        },
      ),
    );
  }
}

// Temporary screens
// We will replace these with the complete screens.

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
      ),
      body: const Center(
        child: Text(
          'Inventory Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      body: const Center(
        child: Text(
          'Sales Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class RepairsScreen extends StatelessWidget {
  const RepairsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Repairs'),
      ),
      body: const Center(
        child: Text(
          'Repairs Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Reports'),
      ),
      body: const Center(
        child: Text(
          'Reports Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}