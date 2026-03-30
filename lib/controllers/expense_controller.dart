import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ExpenseController extends GetxController {
  var transactions  = [].obs;
  var totalIncome   = 0.0.obs;
  var totalExpenses = 0.0.obs;
  var monthlyBudget = 0.0.obs;
  var isLoading     = false.obs;

  var categories = [
    'Food',
    'Transport',
    'Shopping',
    'Entertainment',
    'Health',
    'Education',
    'Utilities',
    'Other',
  ];

  double get balance     => totalIncome.value - totalExpenses.value;
  double get remaining   => monthlyBudget.value - totalExpenses.value;
  double get savingsRate =>
      totalIncome.value == 0 ? 0 : (balance / totalIncome.value) * 100;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    isLoading.value = true;
    try {
      var response = await http.get(
        Uri.parse('http://10.0.2.2/spendrr_app/get_transactions.php'),
      );
      var data = jsonDecode(response.body);
      transactions.value = data['transactions'];
      totalIncome.value   = double.parse(data['total_income'].toString());
      totalExpenses.value = double.parse(data['total_expenses'].toString());
    } catch (e) {
      // Keep existing data on error
    }
    isLoading.value = false;
  }

  Future<bool> addTransaction(
      String title, String amount, String category, String type) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2/spendrr_app/add_expense.php'),
        body: {
          'title':    title,
          'amount':   amount,
          'category': category,
          'type':     type,
        },
      );
      var data = jsonDecode(response.body);
      isLoading.value = false;

      if (data['status'] == 'success') {
        fetchTransactions();
        return true;
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<bool> editTransaction(
      String id, String title, String amount, String category, String type) async {
    isLoading.value = true;
    try {
      var response = await http.post(
        Uri.parse('http://10.0.2.2/spendrr_app/edit_transaction.php'),
        body: {
          'id':       id,
          'title':    title,
          'amount':   amount,
          'category': category,
          'type':     type,
        },
      );
      var data = jsonDecode(response.body);
      isLoading.value = false;

      if (data['status'] == 'success') {
        fetchTransactions();
        return true;
      }
      return false;
    } catch (e) {
      isLoading.value = false;
      return false;
    }
  }

  Future<void> setBudget(double budget) async {
    monthlyBudget.value = budget;
    try {
      await http.post(
        Uri.parse('http://10.0.2.2/spendrr_app/set_budget.php'),
        body: {'budget': budget.toString()},
      );
    } catch (e) {
      // Handle silently
    }
  }

  Map<String, double> get categoryTotals {
    Map<String, double> totals = {};
    for (var t in transactions) {
      if (t['type'] == 'expense') {
        String cat = t['category'] ?? 'Other';
        totals[cat] = (totals[cat] ?? 0) + double.parse(t['amount'].toString());
      }
    }
    return totals;
  }
}