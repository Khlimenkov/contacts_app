import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'contact_event.dart';
part 'contact_state.dart';

/// Buisiness Logic Component ContactBLoC
class ContactBLoC extends Bloc<ContactEvent, ContactState> implements EventSink<ContactEvent> {
  ContactBLoC({
    required final ContactRepository repository,
    final ContactState? initialState,
  })  : _repository = repository,
        super(
          initialState ??
              const ContactState.idle(
                data: [],
                message: 'Initial idle state',
              ),
        ) {
    on<ContactEvent>(
      (event, emit) => event.map<Future<void>>(
        create: (event) => _create(event, emit),
        delete: (event) => _delete(event, emit),
        update: (event) => _update(event, emit),
        fetch: (event) => _fetch(event, emit),
      ),
      transformer: bloc_concurrency.droppable(),
    );
  }

  final ContactRepository _repository;

  /// Fetch event handler
  Future<void> _fetch(FetchContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(data: state.data));
      final newData = await _repository.getContacts();
      emit(ContactState.successfulFetch(data: newData));
    } on Object {
      emit(ContactState.error(data: state.data));
      rethrow;
    } finally {
      emit(ContactState.idle(data: state.data));
    }
  }

  Future<void> _create(CreateContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(data: state.data));
      await _repository.createContact(event.contact);
      final newData = [...state.data, event.contact];
      emit(ContactState.successfulCreate(data: newData, message: 'Contact created'));
    } on Object {
      emit(ContactState.error(data: state.data));
      rethrow;
    } finally {
      emit(ContactState.idle(data: state.data));
    }
  }

  Future<void> _delete(DeleteContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(data: state.data));
      await _repository.deleteContact(event.contactId);
      final newData = List<Contact>.from(state.data);
      newData.removeWhere(
        (element) => element.contactId == event.contactId,
      );
      emit(ContactState.successfulDelete(data: newData, message: 'Contact deleted'));
    } on Object {
      emit(ContactState.error(data: state.data));
      rethrow;
    } finally {
      emit(ContactState.idle(data: state.data));
    }
  }

  Future<void> _update(UpdateContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(data: state.data));
      await _repository.updateContact(event.contact);
      final newData = List<Contact>.from(state.data);
      final contactIdx = newData.indexOf(event.contact);
      newData[contactIdx] = event.contact;
      emit(ContactState.successfulUpdate(data: newData, message: 'Contact updated'));
    } on Object {
      emit(ContactState.error(data: state.data));
      rethrow;
    } finally {
      emit(ContactState.idle(data: state.data));
    }
  }
}
