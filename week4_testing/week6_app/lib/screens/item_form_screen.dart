import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemFormScreen extends StatefulWidget {
  final Item? existing;
  const ItemFormScreen({super.key, this.existing});

  @override
  State<ItemFormScreen> createState() => _ItemFormScreenState();
}

class _ItemFormScreenState extends State<ItemFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtrl;
  late final TextEditingController _subtitleCtrl;
  late final TextEditingController _descriptionCtrl;
  late String _category;
  final List<String> _categories = ['Highlife', 'Hip-hop', 'Gospel'];

  @override
  void initState() {
    super.initState();
    _titleCtrl = TextEditingController(text: widget.existing?.title ?? '');
    _subtitleCtrl =
        TextEditingController(text: widget.existing?.subtitle ?? '');
    _descriptionCtrl =
        TextEditingController(text: widget.existing?.description ?? '');
    _category = widget.existing?.category ?? _categories.first;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subtitleCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final result = (widget.existing ??
            Item(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              title: '',
              subtitle: '',
              description: '',
              category: _categories.first,
              createdAt: DateTime.now(),
            ))
        .copyWith(
      title: _titleCtrl.text,
      subtitle: _subtitleCtrl.text,
      description: _descriptionCtrl.text,
      category: _category,
    );
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;
    return Scaffold(
      appBar: AppBar(title: Text(editing ? 'Edit Item' : 'Add Item')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _titleCtrl,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Title is required';
                if (v.length < 3) return 'At least 3 characters';
                if (v.length > 50) return 'At most 50 characters';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _subtitleCtrl,
              decoration: const InputDecoration(
                labelText: 'Subtitle',
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: _categories
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (v) {
                if (v != null) setState(() => _category = v);
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionCtrl,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Required';
                if (v.length < 10) return 'At least 10 characters';
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(editing ? 'Save Changes' : 'Add Item'),
            ),
          ],
        ),
      ),
    );
  }
}