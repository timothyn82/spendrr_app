import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/colors.dart';
import 'package:spendrr/controllers/expense_controller.dart';

TextEditingController budgetInputCtrl = TextEditingController();

class Budget extends StatefulWidget {
  const Budget({super.key});

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  final ExpenseController controller = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        double budget    = controller.monthlyBudget.value;
        double spent     = controller.totalExpenses.value;
        double remaining = controller.remaining;
        double progress  = budget == 0 ? 0 : (spent / budget).clamp(0, 1);

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
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
                    const Text(
                      'Budget',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manage your monthly budget',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Set budget card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Set Monthly Budget',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: textDark),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: budgetInputCtrl,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter budget amount (KES)',
                          hintStyle:
                              TextStyle(color: subtitleColor, fontSize: 13),
                          prefixIcon: const Icon(Icons.attach_money,
                              color: accentColor),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                BorderSide(color: Colors.grey.shade200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                                color: accentColor, width: 1.5),
                          ),
                          filled: true,
                          fillColor: cardColor,
                        ),
                      ),
                      const SizedBox(height: 14),
                      GestureDetector(
                        onTap: () {
                          double val =
                              double.tryParse(budgetInputCtrl.text) ?? 0;
                          if (val > 0) {
                            controller.setBudget(val);
                            budgetInputCtrl.clear();
                            Get.snackbar(
                              'Budget Set',
                              'Monthly budget set to KES ${val.toStringAsFixed(2)}',
                              backgroundColor: incomeColor,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          } else {
                            Get.snackbar(
                              'Invalid Amount',
                              'Please enter a valid budget',
                              backgroundColor: expenseColor,
                              colorText: Colors.white,
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Container(
                          height: 48,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Save Budget',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Budget progress card
              if (budget > 0)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Budget Overview',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: textDark),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _budgetStat(
                                'Monthly Budget',
                                'KES ${budget.toStringAsFixed(2)}',
                                primaryColor),
                            _budgetStat(
                                'Spent',
                                'KES ${spent.toStringAsFixed(2)}',
                                expenseColor),
                            _budgetStat(
                                'Remaining',
                                'KES ${remaining.toStringAsFixed(2)}',
                                remaining >= 0 ? incomeColor : expenseColor),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Spent ${(progress * 100).toStringAsFixed(1)}%',
                              style: TextStyle(
                                  fontSize: 12, color: subtitleColor),
                            ),
                            Text(
                              '${((1 - progress) * 100).clamp(0, 100).toStringAsFixed(1)}% left',
                              style: TextStyle(
                                  fontSize: 12, color: subtitleColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey.shade100,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              progress >= 0.9 ? expenseColor : accentColor,
                            ),
                            minHeight: 12,
                          ),
                        ),
                        if (progress >= 0.9)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: expenseColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.warning_amber_rounded,
                                      color: expenseColor, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    progress >= 1
                                        ? 'Budget exceeded!'
                                        : 'Almost at budget limit!',
                                    style: const TextStyle(
                                        color: expenseColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // All transactions list
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'All Transactions',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: textDark),
                ),
              ),
              const SizedBox(height: 12),

              Obx(() => controller.transactions.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Center(
                        child: Text('No transactions',
                            style: TextStyle(color: subtitleColor)),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: controller.transactions.length,
                      itemBuilder: (context, index) {
                        var t = controller.transactions[index];
                        bool isExpense = t['type'] == 'expense';
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
                                width: 42,
                                height: 42,
                                decoration: BoxDecoration(
                                  color: isExpense
                                      ? expenseColor.withOpacity(0.1)
                                      : incomeColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isExpense
                                      ? Icons.arrow_upward_rounded
                                      : Icons.arrow_downward_rounded,
                                  color: isExpense ? expenseColor : incomeColor,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  t['title'] ?? 'Transaction',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: textDark),
                                ),
                              ),
                              Text(
                                '${isExpense ? '-' : '+'}KES ${double.parse(t['amount'].toString()).toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: isExpense ? expenseColor : incomeColor),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
              const SizedBox(height: 80),
            ],
          ),
        );
      }),
    );
  }

  Widget _budgetStat(String label, String value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 11, color: subtitleColor)),
        const SizedBox(height: 2),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color)),
      ],
    );
  }
}