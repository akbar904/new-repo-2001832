
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/main.dart';

class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('Main App', () {
		testWidgets('should display Cat with clock icon initially', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('should toggle to Dog with person icon on text tap',
				(tester) async {
			await tester.pumpWidget(MyApp());

			final catTextFinder = find.text('Cat');

			await tester.tap(catTextFinder);
			await tester.pump();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = AnimalCubit();
		});

		blocTest<AnimalCubit, Animal>(
			'should emit Animal with name Dog and person icon on toggleAnimal',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				Animal(name: 'Dog', icon: Icons.person),
			],
		);
	});
}
