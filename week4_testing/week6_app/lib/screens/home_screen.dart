import 'package:flutter/material.dart';
import '../data/item_repository.dart';
import '../models/item.dart';
import '../services/storage_service.dart';
import '../theme/typography_guide.dart';
import 'detail_screen.dart';
import 'item_form_screen.dart';

class Breakpoints {
  static const double tablet = 600;
  static const double desktop = 1000;
}

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
  final _storage = StorageService();
  bool _isLoading = true;
  List<Item> _allItems = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';
  SortMode _sortMode = SortMode.newest;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final saved = await _storage.loadItems();
    final sortIdx = await _storage.loadSortIndex();
    if (!mounted) return;
    setState(() {
      _allItems = saved ?? ItemRepository.sample();
      if (sortIdx != null &&
          sortIdx >= 0 &&
          sortIdx < SortMode.values.length) {
        _sortMode = SortMode.values[sortIdx];
      }
      _isLoading = false;
    });
  }

  Future<void> _updateAndPersist(List<Item> items) async {
    setState(() => _allItems = items);
    await _storage.saveItems(items);
  }

  void _setSortMode(SortMode mode) {
    setState(() => _sortMode = mode);
    _storage.saveSortIndex(mode.index);
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
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              AppText.body(context, 'Loading items...'),
            ],
          ),
        ),
      );
    }
    
    final items = _filteredItems;
    return Scaffold(
      appBar: AppBar(
        title: const Text('INFT 425 — Jonathan Narwotey Nartey'),
        actions: [
          PopupMenuButton<SortMode>(
            icon: const Icon(Icons.sort),
            onSelected: _setSortMode,
            itemBuilder: (_) => SortMode.values
                .map((m) => PopupMenuItem(value: m, child: Text(m.label)))
                .toList(),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddForm,
        child: const Icon(Icons.add),
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
      child: AppText.headline(context, 'Oeses Music: Crafting rhythms that inspire souls.'),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        onChanged: (v) => setState(() => _searchQuery = v),
        decoration: const InputDecoration(
          hintText: 'Search music catalog...',
          prefixIcon: Icon(Icons.search),
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
        child: AppText.caption(context, '${items.length} of ${_allItems.length} items'),
      ),
    );
  }

  Widget _buildList(List<Item> items) {
    return LayoutBuilder(builder: (_, constraints) {
      final width = constraints.maxWidth;
      Widget content;
      if (width >= Breakpoints.desktop) {
        content = GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.6,
          ),
          itemCount: items.length,
          itemBuilder: (_, i) => _buildCard(items[i]),
        );
      } else if (width >= Breakpoints.tablet) {
        content = GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 2.4,
          ),
          itemCount: items.length,
          itemBuilder: (_, i) => _buildCard(items[i]),
        );
      } else {
        content = ListView.builder(
          padding: const EdgeInsets.only(bottom: 16),
          itemCount: items.length,
          itemBuilder: (_, i) => _buildCard(items[i]),
        );
      }
      return RefreshIndicator(onRefresh: _load, child: content);
    });
  }

  Widget _buildCard(Item item) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Delete?'),
            content: Text('Delete "${item.title}"?'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Delete')),
            ],
          ),
        );
      },
      onDismissed: (_) => _deleteWithUndo(item),
      child: Card(
        child: ListTile(
          onTap: () => _openDetail(item),
          leading: Hero(
            tag: 'avatar_${item.id}',
            child: CircleAvatar(child: Text(item.title[0].toUpperCase())),
          ),
          title: AppText.title(context, item.title),
          subtitle: AppText.caption(context, '${item.subtitle} · ${item.category}'),
          trailing: const Icon(Icons.chevron_right),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    final searching = _searchQuery.isNotEmpty;
    final filtering = _selectedCategory != 'All';
    String title;
    String subtitle;
    IconData icon;

    if (searching && filtering) {
      title = 'No results in $_selectedCategory';
      subtitle = 'Try a different search or clear the filter';
      icon = Icons.filter_alt_off;
    } else if (searching) {
      title = 'No results for "$_searchQuery"';
      subtitle = 'Try a different word';
      icon = Icons.search_off;
    } else if (filtering) {
      title = 'No items in $_selectedCategory';
      subtitle = 'Tap "All" to see everything';
      icon = Icons.folder_off;
    } else {
      title = 'No items yet';
      subtitle = 'Tap + to add your first item';
      icon = Icons.inbox_outlined;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: Colors.grey[400]),
            const SizedBox(height: 16),
            AppText.title(context, title),
            const SizedBox(height: 8),
            AppText.caption(context, subtitle),
          ],
        ),
      ),
    );
  }

  Future<void> _openAddForm() async {
    final newItem = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (_) => const ItemFormScreen()),
    );
    if (newItem != null) {
      await _updateAndPersist([..._allItems, newItem]);
    }
  }

  Future<void> _openDetail(Item item) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(
          item: item,
          onEdit: () => _openEditForm(item),
          onDelete: () => _deleteItem(item),
        ),
      ),
    );
  }

  Future<void> _openEditForm(Item item) async {
    final updated = await Navigator.push<Item>(
      context,
      MaterialPageRoute(builder: (_) => ItemFormScreen(existing: item)),
    );
    if (updated != null) {
      final i = _allItems.indexWhere((x) => x.id == item.id);
      if (i != -1) {
        final copy = [..._allItems];
        copy[i] = updated;
        await _updateAndPersist(copy);
      }
    }
  }

  Future<void> _deleteItem(Item item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete?'),
        content: Text('Delete "${item.title}"?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      await _updateAndPersist(
        _allItems.where((x) => x.id != item.id).toList(),
      );
      if (mounted) Navigator.pop(context);
    }
  }

  void _deleteWithUndo(Item item) {
    final backup = [..._allItems];
    final remaining = _allItems.where((x) => x.id != item.id).toList();
    _updateAndPersist(remaining);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted "${item.title}"'),
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => _updateAndPersist(backup),
        ),
      ),
    );
  }
}