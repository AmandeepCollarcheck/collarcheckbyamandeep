import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Add search query and update count
  Future<void> addSearchQuery(String query) async {
    final ref = _firestore.collection('search_history').doc(query);
    final doc = await ref.get();

    if (doc.exists) {
      // If query exists, increase count
      await ref.update({'count': FieldValue.increment(1)});
    } else {
      // If query is new, add it with count = 1
      await ref.set({'query': query, 'count': 1});
    }

    // ✅ Keep only top 10 searches
    await _limitTopSearches();
  }

  /// ✅ Get top 10 searches (ordered by count)
  Stream<List<Map<String, dynamic>>> getTopSearches() {
    return _firestore
        .collection('search_history')
        .orderBy('count', descending: true)
        .limit(10) // Keep only top 10 searches
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  /// ✅ Remove extra searches if more than 10
  Future<void> _limitTopSearches() async {
    final snapshot = await _firestore
        .collection('search_history')
        .orderBy('count', descending: true)
        .get();

    if (snapshot.docs.length > 10) {
      for (int i = 10; i < snapshot.docs.length; i++) {
        await snapshot.docs[i].reference.delete();
      }
    }
  }
}
