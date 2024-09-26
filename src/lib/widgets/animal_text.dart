
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.simple_app/cubits/animal_cubit.dart';
import 'package:com.example.simple_app/models/animal.dart';

class AnimalText extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocBuilder<AnimalCubit, Animal>(
			builder: (context, state) {
				return GestureDetector(
					onTap: () => context.read<AnimalCubit>().toggleAnimal(),
					child: Row(
						children: [
							Text(state.name),
							const SizedBox(width: 8),
							Icon(state.icon),
						],
					),
				);
			},
		);
	}
}
