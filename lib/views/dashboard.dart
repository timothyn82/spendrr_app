import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/colors.dart';
import 'package:spendrr/controllers/expense_controller.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ExpenseController controller = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.fetchTransactions(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(28),
                      bottomRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Good day 👋',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 14,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.notifications_outlined,
                                color: Colors.white, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Total Balance',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'KES ${controller.balance.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _statCard(
                            icon: Icons.arrow_downward_rounded,
                            iconBg: incomeColor,
                            label: 'Income',
                            value:
                                'KES ${controller.totalIncome.value.toStringAsFixed(2)}',
                          ),
                          const SizedBox(width: 12),
                          _statCard(
                            icon: Icons.arrow_upward_rounded,
                            iconBg: expenseColor,
                            label: 'Expenses',
                            value:
                                'KES ${controller.totalExpenses.value.toStringAsFixed(2)}',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Recent Transactions ───────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: textDark,
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                controller.isLoading.value
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child:
                              CircularProgressIndicator(color: primaryColor),
                        ),
                      )
                    : controller.transactions.isEmpty
                        ? _emptyState()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            itemCount:
                                controller.transactions.length > 5
                                    ? 5
                                    : controller.transactions.length,
                            itemBuilder: (context, index) {
                              var t = controller.transactions[index];
                              return _transactionCard(t);
                            },
                          ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconBg, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: const TextStyle(
                        color: Colors.white70, fontSize: 11)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _transactionCard(dynamic t) {
    bool isExpense = t['type'] == 'expense';
    String category = t['category'] ?? 'Other';
    IconData catIcon = _categoryIcon(category);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isExpense
                  ? expenseColor.withOpacity(0.1)
                  : incomeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(catIcon,
                color: isExpense ? expenseColor : incomeColor, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t['title'] ?? 'Transaction',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  category,
                  style: TextStyle(fontSize: 12, color: subtitleColor),
                ),
              ],
            ),
          ),
          Text(
            '${isExpense ? '-' : '+'}KES ${double.parse(t['amount'].toString()).toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: isExpense ? expenseColor : incomeColor,
            ),
          ),
          const SizedBox(width: 8),
          // ── Edit icon ──────────────────────────────────────────────
          GestureDetector(
            onTap: () => _showEditDialog(context, t),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.edit_outlined,
                  size: 16, color: accentColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, dynamic t) {
    TextEditingController editTitleCtrl =
        TextEditingController(text: t['title']);
    TextEditingController editAmountCtrl =
        TextEditingController(text: t['amount'].toString());
    String editType     = t['type'];
    String editCategory = t['category'] ?? 'Other';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          bool isExpense = editType == 'expense';
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
              top: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit Transaction',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: textDark,
                  ),
                ),
                const SizedBox(height: 16),

                // Type toggle
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setModalState(() => editType = 'expense'),
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isExpense ? expenseColor : cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Expense',
                            style: TextStyle(
                              color: isExpense ? Colors.white : subtitleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setModalState(() => editType = 'income'),
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: !isExpense ? incomeColor : cardColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Income',
                            style: TextStyle(
                              color:
                                  !isExpense ? Colors.white : subtitleColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Title
                TextField(
                  controller: editTitleCtrl,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: cardColor,
                  ),
                ),
                const SizedBox(height: 12),

                // Amount
                TextField(
                  controller: editAmountCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount (KES)',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    filled: true,
                    fillColor: cardColor,
                  ),
                ),
                const SizedBox(height: 20),

                // Save button
                GestureDetector(
                  onTap: () async {
                    bool success = await controller.editTransaction(
                      t['id'].toString(),
                      editTitleCtrl.text,
                      editAmountCtrl.text,
                      editCategory,
                      editType,
                    );
                    if (success) {
                      Get.back();
                      Get.snackbar(
                        'Updated!',
                        'Transaction updated successfully',
                        backgroundColor: incomeColor,
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Save Changes',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _emptyState() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.receipt_long_outlined,
                size: 52, color: Colors.grey.shade300),
            const SizedBox(height: 12),
            Text(
              'No transactions yet',
              style: TextStyle(color: subtitleColor, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              'Tap + to add your first transaction',
              style:
                  TextStyle(color: Colors.grey.shade400, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  IconData _categoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food':          return Icons.restaurant_outlined;
      case 'transport':     return Icons.directions_car_outlined;
      case 'shopping':      return Icons.shopping_bag_outlined;
      case 'entertainment': return Icons.movie_outlined;
      case 'health':        return Icons.health_and_safety_outlined;
      case 'education':     return Icons.school_outlined;
      case 'utilities':     return Icons.bolt_outlined;
      case 'income':        return Icons.account_balance_outlined;
      default:              return Icons.category_outlined;
    }
  }
}