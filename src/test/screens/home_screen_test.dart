
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_app/screens/home_screen.dart';

// Mocking the AnimalCubit
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays "Cat" with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays "Dog" with person icon when state is toggled', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Dog', icon: Icons.person));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles text and icon on tap', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([
					Animal(name: 'Cat', icon: Icons.access_time),
					Animal(name: 'Dog', icon: Icons.person),
				]),
				initialState: Animal(name: 'Cat', icon: Icons.access_time),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pump();

			verify(() => animalCubit.toggleAnimal()).called(1);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});
	});
}
