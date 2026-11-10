import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/item.dart';

class StorageService {
  static const _itemsKey = 'items_v1';
  static const _sortKey = 'sort_index_v1';
  final _prefs = SharedPreferencesAsync();

  Future<List<Item>?> loadItems() async {
    final raw = await _prefs.getString(_itemsKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> saveItems(List<Item> items) async {
    await _prefs.setString(
      _itemsKey,
      jsonEncode(items.map((i) => i.toJson()).toList()),
    );
  }

  Future<int?> loadSortIndex() async => _prefs.getInt(_sortKey);
  Future<void> saveSortIndex(int index) async =>
      _prefs.setInt(_sortKey, index);
}