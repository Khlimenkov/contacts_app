import 'dart:async';
import 'dart:convert';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:contacts_app/src/feature/feed/data/key_value_repository.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'feed_event.dart';
part 'feed_state.dart';

/// Buisiness Logic Component ContactBLoC
class FeedBLoC extends Bloc<FeedEvent, FeedState> implements EventSink<FeedEvent> {
  FeedBLoC({
    required final ContactRepository repository,
    required final KeyValueRepository keyValueRepository,
    final FeedState? initialState,
  })  : _repository = repository,
        _keyValueRepository = keyValueRepository,
        super(
          initialState ??
              const FeedState.idle(
                data: [],
                message: 'Initial idle state',
              ),
        ) {
    on<FeedEvent>(
      (event, emit) => event.map<Future<void>>(
        fetch: (event) => _fetch(event, emit),
        init: (event) => _init(event, emit),
      ),
      transformer: bloc_concurrency.sequential<FeedEvent>(),
    );
  }

  final ContactRepository _repository;

  final KeyValueRepository _keyValueRepository;

  /// Fetch event handler
  Future<void> _fetch(FetchFeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(FeedState.processing(data: state.data));
      final newData = await _repository.getContacts();
      emit(FeedState.successfulFetch(data: newData));
    } on Object {
      emit(FeedState.error(data: state.data));
      rethrow;
    } finally {
      emit(FeedState.idle(data: state.data));
    }
  }

  Future<void> _init(InitFeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(FeedState.processing(data: state.data));
      if (!_keyValueRepository.containsKey('isNotFirstRun')) {
        final jsonString = await rootBundle.loadString('assets/contacts.json');
        final json = jsonDecode(jsonString) as List;
        final contacts = json.map((e) => Contact.fromJson(e)).toList();
        await _repository.putMany(contacts);
        _keyValueRepository.setValue('isNotFirstRun', true);
      }
    } on Object {
      emit(FeedState.error(data: state.data));
      rethrow;
    } finally {
      emit(FeedState.idle(data: state.data));
    }
  }
}
