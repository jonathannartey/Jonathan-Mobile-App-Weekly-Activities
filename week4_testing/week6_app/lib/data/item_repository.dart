import '../models/item.dart';

class ItemRepository {
  static List<Item> sample() => [
        Item(
          id: '1',
          title: 'Oheneba',
          subtitle: 'Highlife Classics',
          description: 'A smooth contemporary highlife instrumental blend featuring rich guitar riffs.',
          category: 'Highlife',
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        Item(
          id: '2',
          title: 'Street Anthem',
          subtitle: 'Urban Beats',
          description: 'An energetic hip-hop rhythm produced for underground cyphers.',
          category: 'Hip-hop',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Item(
          id: '3',
          title: 'Grace & Mercy',
          subtitle: 'Porship Mix',
          description: 'An uplifting gospel sound package engineered for Sunday morning worship.',
          category: 'Gospel',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
        ),
        Item(
          id: '4',
          title: 'Akomayɛ',
          subtitle: 'Highlife Grooves',
          description: 'Mid-tempo rhythmic fusion with traditional percussion loops.',
          category: 'Highlife',
          createdAt: DateTime.now(),
        ),
        Item(
          id: '5',
          title: 'Kingdom Sound',
          subtitle: 'Inspirational',
          description: 'Soulful keyboard chord progressions and vocal pads.',
          category: 'Gospel',
          createdAt: DateTime.now(),
        ),
      ];
}