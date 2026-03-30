import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendrr/configs/colors.dart';
import 'package:spendrr/controllers/expense_controller.dart';

TextEditingController titleCtrl  = TextEditingController();
TextEditingController amountCtrl = TextEditingController();

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final ExpenseController controller = Get.find<ExpenseController>();
  String selectedCategory = 'Food';
  String selectedType     = 'expense'; // ✅ toggle state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add Transaction',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 20,
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── Income / Expense Toggle ──────────────────────────
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Expense tab
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = 'expense';
                                selectedCategory = 'Food';
                              });
                            },
                            child: Container(
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedType == 'expense'
                                    ? expenseColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_upward_rounded,
                                    size: 16,
                                    color: selectedType == 'expense'
                                        ? Colors.white
                                        : subtitleColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Expense',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: selectedType == 'expense'
                                          ? Colors.white
                                          : subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Income tab
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedType = 'income';
                                selectedCategory = 'Salary';
                              });
                            },
                            child: Container(
                              height: 44,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedType == 'income'
                                    ? incomeColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 16,
                                    color: selectedType == 'income'
                                        ? Colors.white
                                        : subtitleColor,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Income',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: selectedType == 'income'
                                          ? Colors.white
                                          : subtitleColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Amount ───────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
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
                        Text(
                          selectedType == 'expense'
                              ? 'How much did you spend?'
                              : 'How much did you earn?',
                          style: TextStyle(fontSize: 13, color: subtitleColor),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: amountCtrl,
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: textDark,
                          ),
                          decoration: InputDecoration(
                            hintText: '0.00',
                            hintStyle: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade300,
                            ),
                            prefixText: 'KES ',
                            prefixStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: selectedType == 'expense'
                                  ? expenseColor
                                  : incomeColor,
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Title ────────────────────────────────────────────
                  Container(
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
                          'Title',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: titleCtrl,
                          decoration: InputDecoration(
                            hintText: selectedType == 'expense'
                                ? 'e.g. Lunch at restaurant'
                                : 'e.g. Monthly salary',
                            hintStyle: TextStyle(color: subtitleColor, fontSize: 13),
                            prefixIcon: const Icon(Icons.edit_outlined,
                                color: accentColor, size: 20),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: accentColor, width: 1.5),
                            ),
                            filled: true,
                            fillColor: cardColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Category ─────────────────────────────────────────
                  Container(
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
                          'Category',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: textDark,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: (selectedType == 'expense'
                                  ? controller.categories
                                  : controller.categories)
                              .map((cat) {
                            bool isSelected = selectedCategory == cat;
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = cat;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? (selectedType == 'expense'
                                          ? expenseColor
                                          : incomeColor)
                                      : cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: isSelected
                                        ? (selectedType == 'expense'
                                            ? expenseColor
                                            : incomeColor)
                                        : Colors.grey.shade200,
                                  ),
                                ),
                                child: Text(
                                  cat,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : subtitleColor,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ── Save Button ──────────────────────────────────────
                  Obx(
                    () => GestureDetector(
                      onTap: controller.isLoading.value
                          ? null
                          : () async {
                              if (titleCtrl.text.isEmpty ||
                                  amountCtrl.text.isEmpty) {
                                Get.snackbar(
                                  'Missing Fields',
                                  'Please fill in all fields',
                                  backgroundColor: expenseColor,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                return;
                              }
                              bool success = await controller.addTransaction(
                                titleCtrl.text,
                                amountCtrl.text,
                                selectedCategory,
                                selectedType,
                              );
                              if (success) {
                                titleCtrl.clear();
                                amountCtrl.clear();
                                Get.back();
                                Get.snackbar(
                                  'Saved!',
                                  '${selectedType == 'expense' ? 'Expense' : 'Income'} added successfully',
                                  backgroundColor: incomeColor,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'Could not save. Try again.',
                                  backgroundColor: expenseColor,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                              }
                            },
                      child: Container(
                        height: 54,
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedType == 'expense'
                              ? expenseColor
                              : incomeColor,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: (selectedType == 'expense'
                                      ? expenseColor
                                      : incomeColor)
                                  .withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    selectedType == 'expense'
                                        ? Icons.arrow_upward_rounded
                                        : Icons.arrow_downward_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedType == 'expense'
                                        ? 'Save Expense'
                                        : 'Save Income',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}