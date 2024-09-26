
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_app/widgets/animal_text.dart';
import 'package:com.example.simple_app/cubits/animal_cubit.dart';
import 'package:com.example.simple_app/models/animal.dart';

// Mock AnimalCubit
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalText Widget', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat with clock icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => animalCubit,
						child: AnimalText(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});

		testWidgets('displays Dog with person icon on toggle', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Dog', icon: Icons.person));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => animalCubit,
						child: AnimalText(),
					),
				),
			);

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles state on tap', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(Animal(name: 'Cat', icon: Icons.access_time));
			when(() => animalCubit.toggleAnimal()).thenAnswer((_) async {
				when(() => animalCubit.state).thenReturn(Animal(name: 'Dog', icon: Icons.person));
			});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (_) => animalCubit,
						child: AnimalText(),
					),
				),
			);

			await tester.tap(find.text('Cat'));
			await tester.pumpAndSettle();

			verify(() => animalCubit.toggleAnimal()).called(1);
		});
	});
}
