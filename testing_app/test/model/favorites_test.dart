import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/prvoider/counter_provider.dart';
import 'package:testing_app/prvoider/favorites_provider.dart';

void main() {
  group('Testing App Provider', () {
    var favorites = FavoritesPovider();
    var counter = CounterProvider();

    test('value of counter at start', () {
      expect(counter.counter, 0);
    });

    test('value should be increment', () {
      counter.increment();
      expect(counter.counter, 1);
    });

    test('value should be derement', () {
      counter.decrement();
      expect(counter.counter, 0);
    });

    test('value should start at 0', () {
      expect(favorites.items.isEmpty, true);
    });
    test('A new item should be added', () {
      var number = 35;
      favorites.add(number);
      expect(favorites.items.contains(number), true);
    });
  });
}
