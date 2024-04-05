import 'package:lab010/models/bakery.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';


class MockJsonMap extends Mock implements Map<String, Object?> {}

void main() {
  group('Bakery', () {
    late Bakery bakery;
    late Map<String, Object?> mockJson;

    setUp(() {
      mockJson = MockJsonMap();
      when(mockJson['name']).thenReturn('Croissant');
      when(mockJson['price']).thenReturn(5);

      bakery = Bakery.fromJson(mockJson);
    });

    test('fromJson() should create a Bakery object from JSON data', () {
      expect(bakery.name, 'Croissant');
      expect(bakery.price, 5);
    });

    test('copyWith() should create a new Bakery object with updated values', () {
      final updatedBakery = bakery.copyWith(name: 'Donut', price: 3);

      expect(updatedBakery.name, 'Donut');
      expect(updatedBakery.price, 3);
    });

    test('toJson() should convert Bakery object to JSON data', () {
      final json = bakery.toJson();

      expect(json['name'], 'Croissant');
      expect(json['price'], 5);
    });
  });
}