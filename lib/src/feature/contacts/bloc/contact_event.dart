part of 'contact_bloc.dart';

sealed class ContactEvent extends _ContactEventBase {
  const ContactEvent();

  /// Create
  const factory ContactEvent.create({required Contact contact}) = CreateContactEvent;

  /// Fetch
  const factory ContactEvent.fetch() = FetchContactEvent;

  /// Update
  const factory ContactEvent.update({required Contact contact}) = UpdateContactEvent;

  /// Delete
  const factory ContactEvent.delete({required String contactId}) = DeleteContactEvent;
}

final class CreateContactEvent extends ContactEvent with _ContactEvent {
  final Contact contact;
  const CreateContactEvent({required this.contact});
}

final class FetchContactEvent extends ContactEvent with _ContactEvent {
  const FetchContactEvent();
}

final class UpdateContactEvent extends ContactEvent with _ContactEvent {
  final Contact contact;
  const UpdateContactEvent({required this.contact});
}

final class DeleteContactEvent extends ContactEvent with _ContactEvent {
  final String contactId;
  const DeleteContactEvent({required this.contactId});
}

base mixin _ContactEvent on ContactEvent {}

/// Pattern matching for [ContactEvent].
typedef ContactEventMatch<R, S extends ContactEvent> = R Function(S state);

abstract base class _ContactEventBase {
  const _ContactEventBase();

  /// Pattern matching for [ContactState].
  R map<R>({
    required ContactEventMatch<R, CreateContactEvent> create,
    required ContactEventMatch<R, FetchContactEvent> fetch,
    required ContactEventMatch<R, UpdateContactEvent> update,
    required ContactEventMatch<R, DeleteContactEvent> delete,
  }) =>
      switch (this) {
        CreateContactEvent e => create(e),
        FetchContactEvent e => fetch(e),
        UpdateContactEvent e => update(e),
        DeleteContactEvent e => delete(e),
        _ => throw AssertionError(),
      };
}
