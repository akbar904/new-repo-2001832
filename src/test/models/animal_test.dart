
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/models/animal.dart';

void main() {
	group('Animal Model Tests', () {
		test('Animal model should have correct name and icon', () {
			// Arrange
			const name = 'Cat';
			const icon = Icons.access_time;

			// Act
			final animal = Animal(name: name, icon: icon);

			// Assert
			expect(animal.name, name);
			expect(animal.icon, icon);
		});

		test('Animal model should serialize to JSON', () {
			// Arrange
			const name = 'Cat';
			const icon = Icons.access_time;
			final animal = Animal(name: name, icon: icon);
			final expectedJson = {
				'name': name,
				'icon': Icons.access_time.codePoint,
			};

			// Act
			final json = animal.toJson();

			// Assert
			expect(json, expectedJson);
		});

		test('Animal model should deserialize from JSON', () {
			// Arrange
			const name = 'Cat';
			const iconCodePoint = Icons.access_time.codePoint;
			final json = {
				'name': name,
				'icon': iconCodePoint,
			};

			// Act
			final animal = Animal.fromJson(json);

			// Assert
			expect(animal.name, name);
			expect(animal.icon, Icons.access_time);
		});
	});
}
