import 'package:carousel_slider/carousel_controller.dart';
import 'package:clean_architecture_test/core/presentation/widgets/image_box.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_bloc.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_event.dart';
import 'package:clean_architecture_test/features/users/presentation/bloc/users_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key, required this.id});

  final String id;

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final controller = CarouselSliderController();

  @override
  void initState() {
    context.read<UsersBloc>().add(UserFetched(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: Colors.black,
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          return state.isUserLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      spacing: 24.0,
                      children: [
                        ImageBox(imageUrl: state.user?.avatar ?? ''),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          spacing: 8.0,
                          children: [
                            Text(
                              '\$${state.user?.email}',
                              style: textTheme.bodyMedium,
                            ),
                            Text(
                              '${state.user?.name}',
                              style: textTheme.bodyLarge,
                            ),
                            Text(
                              '${state.user?.role}',
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}
