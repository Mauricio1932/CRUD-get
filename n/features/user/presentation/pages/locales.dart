import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:localeats/features/user/presentation/pages/create_account.dart';
// import 'package:localeats/features/user/presentation/pages/profile.dart';

import '../bloc/bloc_locales/locales_bloc.dart';
import '../bloc/bloc_locales/locales_event.dart';
import '../bloc/bloc_locales/locales_state.dart';

class LocalView extends StatefulWidget {
  const LocalView({super.key});

  @override
  State<LocalView> createState() => __LocalViewState();
}

class __LocalViewState extends State<LocalView> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: BlocBuilder<LocalesBloc, LocalesState>(
          builder: (context, state) {
            if (state.localesStatus == LocalesRequest.requestInProgress) {
              return const CircularProgressIndicator();
            }
            if (state.localesStatus == LocalesRequest.requestFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Problem loading products'),
                  const SizedBox(
                    height: 10,
                  ),
                  OutlinedButton(
                      onPressed: () {
                        context.read<LocalesBloc>().add(LocalRequest());
                      },
                      child: const Text('Try again'))
                ],
              );
            }
            if (state.localesStatus == LocalesRequest.unknown) {
              context.read<LocalesBloc>().add(LocalRequest());
            }

            return Column(children: [
              const SizedBox(height: 0),
              const Padding(
                padding: EdgeInsets.only(top: 18.0, left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Locales Destacados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
                    scrollDirection: Axis.vertical,
                    itemCount: state.locales.length,
                    itemBuilder: (BuildContext context, int index) {
                      final local = state.locales[index];
                      // final inLocal = state.localId.contains(local.id);

                      return InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: deviceWidth * 0.8,
                                  height: 135,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: DecorationImage(
                                      image: NetworkImage(local
                                          .image), // Utiliza NetworkImage para cargar la imagen desde la red
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        // Acción al hacer clic en la imagen
                                        // Agrega aquí el código que deseas ejecutar al hacer clic en la imagen
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  width: deviceWidth * 0.8,
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    local.title,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  width: deviceWidth * 0.8,
                                  padding: const EdgeInsets.all(0.0),
                                  child: Text(
                                    local.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 30),
              const Padding(
                padding: EdgeInsets.only(top: 0.0, left: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Todos los locales',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 60),
            ]);
          },
        ),
      ),
    );
  }
}
