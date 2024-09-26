
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/animal_cubit.dart';

// Mocking the dependencies if necessary
class MockAnimalCubit extends MockCubit<Animal> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		late AnimalCubit animalCubit;
		
		setUp(() {
			animalCubit = AnimalCubit();
		});

		tearDown(() {
			animalCubit.close();
		});

		test('initial state is Animal with name "Cat" and clock icon', () {
			expect(animalCubit.state.name, 'Cat');
			expect(animalCubit.state.icon, Icons.access_time);
		});

		blocTest<AnimalCubit, Animal>(
			'emits Animal with name "Dog" and person icon when toggleAnimal is called and current state is Cat',
			build: () => animalCubit,
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: 'Dog', icon: Icons.person)],
		);

		blocTest<AnimalCubit, Animal>(
			'emits Animal with name "Cat" and clock icon when toggleAnimal is called and current state is Dog',
			build: () => animalCubit,
			seed: () => Animal(name: 'Dog', icon: Icons.person),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [Animal(name: 'Cat', icon: Icons.access_time)],
		);
	});
}
