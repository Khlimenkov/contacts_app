import 'package:contacts_app/src/feature/feed/bloc/feed_bloc.dart';
import 'package:contacts_app/src/feature/feed/widget/feed_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

/// FeedScreen widget
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Contacts'),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => context.goNamed('NewContact'),
        ),
        body: BlocBuilder<FeedBLoC, FeedState>(
          builder: (context, state) {
            if (state.isProcessing) {
              return const Center(
                child: RepaintBoundary(
                  child: CircularProgressIndicator(),
                ),
              );
            } else if (state.isNotEmpty) {
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  FeedList(contactList: state.data),
                ],
              );
            } else {
              return const Center(
                child: Text(
                  'No contacts yet.',
                ),
              );
            }
          },
        ),
      );
}
