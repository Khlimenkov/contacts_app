import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:contacts_app/src/feature/contacts/data/contact_repository.dart';
import 'package:contacts_app/src/feature/contacts/model/contact.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'contact_event.dart';
part 'contact_state.dart';

/// Buisiness Logic Component ContactBLoC
class ContactBLoC extends Bloc<ContactEvent, ContactState> implements EventSink<ContactEvent> {
  ContactBLoC({
    required final ContactRepository repository,
    required final Contact contact,
  })  : _repository = repository,
        super(
          ContactState.idle(
            contact: contact,
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

  factory ContactBLoC.creation({
    required final ContactRepository repository,
  }) =>
      ContactBLoC(
        repository: repository,
        contact: repository.getNewContactTemplate(),
      );

  final ContactRepository _repository;

  /// Fetch event handler
  Future<void> _fetch(FetchContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(contact: state.contact));
      final fetchedContact = await _repository.getContact(state.contact.contactId);
      emit(ContactState.successfulFetch(contact: fetchedContact));
    } on Object {
      emit(ContactState.error(contact: state.contact));
      rethrow;
    } finally {
      emit(ContactState.idle(contact: state.contact));
    }
  }

  Future<void> _create(CreateContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(contact: state.contact));

      final newContact = await _repository.createContact(event.contact.copyWith(contactId: const Uuid().v4()));
      emit(ContactState.successfulCreate(contact: newContact, message: 'Contact created'));
    } on Object {
      emit(ContactState.error(contact: state.contact));
      rethrow;
    } finally {
      emit(ContactState.idle(contact: state.contact));
    }
  }

  Future<void> _delete(DeleteContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(contact: state.contact));
      final deletedContact = await _repository.deleteContact(event.contactId);
      emit(ContactState.successfulDelete(contact: deletedContact, message: 'Contact deleted'));
    } on Object {
      emit(ContactState.error(contact: state.contact));
      rethrow;
    } finally {
      emit(ContactState.idle(contact: state.contact));
    }
  }

  Future<void> _update(UpdateContactEvent event, Emitter<ContactState> emit) async {
    try {
      emit(ContactState.processing(contact: state.contact));
      final updatedContact = await _repository.updateContact(event.contact);
      emit(ContactState.successfulUpdate(contact: updatedContact, message: 'Contact updated'));
    } on Object {
      emit(ContactState.error(contact: state.contact));
      rethrow;
    } finally {
      emit(ContactState.idle(contact: state.contact));
    }
  }
}
