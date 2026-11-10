import 'package:flutter/material.dart';
import '../data/item_repository.dart';
import '../models/item.dart';

enum SortMode {
  newest('Newest first'),
  oldest('Oldest first'),
  nameAsc('Name A–Z'),
  nameDesc('Name Z–A');

  final String label;
  const SortMode(this.label);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Item> _allItems = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';
  SortMode _sortMode = SortMode.newest;

  @override
  void initState() {
    super.initState();
    _allItems = ItemRepository.sample();
  }

  List<Item> get _filteredItems {
    var result = _allItems;
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((item) =>
              item.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.subtitle.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              item.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
    if (_selectedCategory != 'All') {
      result = result
          .where((item) => item.category == _selectedCategory)
          .toList();
    }
    switch (_sortMode) {
      case SortMode.newest:
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case SortMode.oldest:
        result.sort((a, b) => a.createdAt.compareTo(b.createdAt));
        break;
      case SortMode.nameAsc:
        result.sort((a, b) => a.title.compareTo(b.title));
        break;
      case SortMode.nameDesc:
        result.sort((a, b) => b.title.compareTo(a.title));
        break;
    }
    return result;
  }

  List<String> get _categories {
    final cats = _allItems.map((i) => i.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  @override
  Widget build(BuildContext context) {
    final items = _filteredItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFT 425 — Jonathan Narwotey Nartey'),
        actions: [
          PopupMenuButton<SortMode>(
            icon: const Icon(Icons.sort),
            onSelected: (m) => setState(() => _sortMode = m),
            itemBuilder: (_) => SortMode.values
                .map((m) => PopupMenuItem(value: m, child: Text(m.label)))
                .toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSignatureHeader(),
          _buildSearchBar(),
          _buildChips(),
          _buildStats(items),
          Expanded(
            child: items.isEmpty ? _buildEmpty() : _buildList(items),
          ),
        ],
      ),
    );
  }

  Widget _buildSignatureHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F766E), Color(0xFFF59E0B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Text(
        'Oeses Music: Crafting rhythms that inspire souls.',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: InputDecoration(
          hintText: 'Search music catalog...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildChips() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (_, i) {
          final cat = _categories[i];
          final isSelected = _selectedCategory == cat;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(cat),
              selected: isSelected,
              onSelected: (_) => setState(() => _selectedCategory = cat),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStats(List<Item> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('${items.length} of ${_allItems.length} items',
            style: const TextStyle(color: Colors.grey)),
      ),
    );
  }

  Widget _buildList(List<Item> items) {
    return LayoutBuilder(builder: (_, constraints) {
      if (constraints.maxWidth >= 600) {
        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 3.5,
          ),
          itemCount: items.length,
          itemBuilder: (_, i) => _buildCard(items[i]),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: items.length,
        itemBuilder: (_, i) => _buildCard(items[i]),
      );
    });
  }

  Widget _buildCard(Item item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: CircleAvatar(child: Text(item.title[0].toUpperCase())),
        title: Text(item.title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${item.subtitle} · ${item.category}'),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }

  Widget _buildEmpty() {
    final searching = _searchQuery.isNotEmpty;
    final filtering = _selectedCategory != 'All';
    String message;
    if (searching && filtering) {
      message = 'No results for "$_searchQuery" in category "$_selectedCategory"';
    } else if (searching) {
      message = 'No results for "$_searchQuery"';
    } else if (filtering) {
      message = 'No items found in category "$_selectedCategory"';
    } else {
      message = 'No items available';
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}