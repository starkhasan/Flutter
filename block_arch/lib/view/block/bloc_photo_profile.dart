import 'package:block_arch/bloc/bloc_states/photo_state.dart';
import 'package:block_arch/bloc/photo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocPhotoProfile extends StatelessWidget {
  const BlocPhotoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhotoBloc(), 
      child: const MainScreen()
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PhotoBloc>().add(PhotoFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Photo Profile', style: TextStyle(fontSize: 14))
      ),
      body: BlocConsumer<PhotoBloc, PhotoState>(
        listener: (context, state){
          print(state);
        },
        builder:(context, state) {
          return state.status.isSuccess
          ? ListView.builder(
              itemCount: state.photoResponse.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index){
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(state.photoResponse[index].thumbNail),
                            ),
                            const SizedBox(width: 10),
                            Flexible(child: Text(state.photoResponse[index].title))
                          ]
                        )
                      ),
                      IconButton(onPressed: () => context.read<PhotoBloc>().add(PhotoDeleteEven(index: index)), icon: const Icon(Icons.delete))
                    ]
                  )
                );
              }
            )
          : state.status.isLoading
            ? const CircularProgressIndicator()
            : const Center(child: Text('Photo not found'));
        }
      )
    );
  }
}
