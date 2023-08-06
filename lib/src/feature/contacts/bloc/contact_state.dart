part of 'contact_bloc.dart';

/// ContactState.
sealed class ContactState extends _ContactStateBase {
  const factory ContactState.idle({
    required Contact contact,
    String message,
  }) = ContactStateIdle;

  const factory ContactState.processing({
    required Contact contact,
    String message,
  }) = ContactStateProcessing;

  const factory ContactState.successfulFetch({
    required Contact contact,
    String message,
  }) = ContactStateSuccessfulFetch;

  const factory ContactState.successfulCreate({
    required Contact contact,
    String message,
  }) = ContactStateSuccessfulCreate;

  const factory ContactState.successfulUpdate({
    required Contact contact,
    String message,
  }) = ContactStateSuccessfulUpdate;

  const factory ContactState.successfulDelete({
    required Contact contact,
    String message,
  }) = ContactStateSuccessfulDelete;

  const factory ContactState.error({
    required Contact contact,
    String message,
  }) = ContactStateError;

  const ContactState({required super.contact, required super.message});
}

/// Idling state
final class ContactStateIdle extends ContactState with _ContactState {
  const ContactStateIdle({required super.contact, super.message = 'Idling'});
}

/// Processing
final class ContactStateProcessing extends ContactState with _ContactState {
  const ContactStateProcessing({required super.contact, super.message = 'Processing'});
}

/// Successful
final class ContactStateSuccessfulFetch extends ContactState with _ContactState {
  const ContactStateSuccessfulFetch({required super.contact, super.message = 'Successful'});
}

/// Successful create
final class ContactStateSuccessfulCreate extends ContactState with _ContactState {
  const ContactStateSuccessfulCreate({required super.contact, super.message = 'Successful'});
}

/// Successful update
final class ContactStateSuccessfulUpdate extends ContactState with _ContactState {
  const ContactStateSuccessfulUpdate({required super.contact, super.message = 'Successful'});
}

/// Successful delete
final class ContactStateSuccessfulDelete extends ContactState with _ContactState {
  const ContactStateSuccessfulDelete({required super.contact, super.message = 'Successful'});
}

/// Error
final class ContactStateError extends ContactState with _ContactState {
  const ContactStateError({required super.contact, super.message = 'An error has occurred.'});
}

base mixin _ContactState on ContactState {}

/// Pattern matching for [ContactState].
typedef ContactStateMatch<R, S extends ContactState> = R Function(S state);

@immutable
abstract base class _ContactStateBase {
  const _ContactStateBase({required this.contact, required this.message});

  /// Data entity payload.
  final Contact contact;

  /// Message or state description.
  final String message;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [ContactState].
  R map<R>({
    required ContactStateMatch<R, ContactStateIdle> idle,
    required ContactStateMatch<R, ContactStateProcessing> processing,
    required ContactStateMatch<R, ContactStateSuccessfulFetch> successfulFetch,
    required ContactStateMatch<R, ContactStateSuccessfulCreate> successfulCreate,
    required ContactStateMatch<R, ContactStateSuccessfulUpdate> successfulUpdate,
    required ContactStateMatch<R, ContactStateSuccessfulDelete> successfulDelete,
    required ContactStateMatch<R, ContactStateError> error,
  }) =>
      switch (this) {
        ContactStateIdle s => idle(s),
        ContactStateProcessing s => processing(s),
        ContactStateSuccessfulFetch s => successfulFetch(s),
        ContactStateSuccessfulCreate s => successfulCreate(s),
        ContactStateSuccessfulUpdate s => successfulUpdate(s),
        ContactStateSuccessfulDelete s => successfulDelete(s),
        ContactStateError s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [ContactState].
  R maybeMap<R>({
    ContactStateMatch<R, ContactStateIdle>? idle,
    ContactStateMatch<R, ContactStateProcessing>? processing,
    ContactStateMatch<R, ContactStateSuccessfulFetch>? successfulFetch,
    ContactStateMatch<R, ContactStateSuccessfulCreate>? successfulCreate,
    ContactStateMatch<R, ContactStateSuccessfulUpdate>? successfulUpdate,
    ContactStateMatch<R, ContactStateSuccessfulDelete>? successfulDelete,
    ContactStateMatch<R, ContactStateError>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successfulFetch: successfulFetch ?? (_) => orElse(),
        successfulCreate: successfulCreate ?? (_) => orElse(),
        successfulUpdate: successfulUpdate ?? (_) => orElse(),
        successfulDelete: successfulDelete ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [ContactState].
  R? mapOrNull<R>({
    ContactStateMatch<R, ContactStateIdle>? idle,
    ContactStateMatch<R, ContactStateProcessing>? processing,
    ContactStateMatch<R, ContactStateSuccessfulFetch>? successfulFetch,
    ContactStateMatch<R, ContactStateSuccessfulCreate>? successfulCreate,
    ContactStateMatch<R, ContactStateSuccessfulUpdate>? successfulUpdate,
    ContactStateMatch<R, ContactStateSuccessfulDelete>? successfulDelete,
    ContactStateMatch<R, ContactStateError>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successfulFetch: successfulFetch ?? (_) => null,
        successfulCreate: successfulCreate ?? (_) => null,
        successfulUpdate: successfulUpdate ?? (_) => null,
        successfulDelete: successfulDelete ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => contact.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ContactStateBase && runtimeType == other.runtimeType && contact.contactId == other.contact.contactId;
}
