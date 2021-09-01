import 'package:block_arch/bloc/bloc_states/weather_state.dart';
import 'package:block_arch/models/weather_response.dart';
import 'package:block_arch/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherReportScreen extends StatelessWidget {
  const WeatherReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(),
      child: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(WeatherEvent.initialRequestEvent);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Weather Report'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (BuildContext context, state) {
          if (state is WeatherUninitializedState) {
            return buildWidget('Uninitialized State');
          } else if (state is WeatherFetchingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WeatherErrorState) {
            return buildWidget('Not Working');
          } else {
            state as WeatherFetchedState;
            return buildContent(state.weatherResponse);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<WeatherBloc>().add(WeatherEvent.fabRequestEvent),
        child: const Icon(Icons.refresh_rounded)
      )
    );
  }

  Widget buildWidget(String message) {
    return Center(child: Text(message));
  }

  Widget buildContent(WeatherResponse response) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(response.name),
          Text('Temperature = ${response.main.tempMax.toString()}')
        ]
      )
    );
  }
}
