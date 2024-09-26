
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_app/cubits/animal_cubit.dart';
import 'package:simple_app/widgets/animal_text.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Animal App'),
			),
			body: BlocBuilder<AnimalCubit, Animal>(
				builder: (context, animal) {
					return Center(
						child: GestureDetector(
							onTap: () => context.read<AnimalCubit>().toggleAnimal(),
							child: AnimalText(animal: animal),
						),
					);
				},
			),
		);
	}
}
