class FirestoreService {
  Future<void> uploadTransaction(Map<String, dynamic> data) async {
    // Send transaction to Firestore
  }

  Future<void> uploadCategories(List<Map<String, dynamic>> categories) async {
    // Upload custom categories to Firestore
  }

  Future<List<Map<String, dynamic>>> fetchTransactions() async {
    // Retrieve transactions from Firestore
    return [];
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    // Retrieve categories from Firestore
    return [];
  }
}
