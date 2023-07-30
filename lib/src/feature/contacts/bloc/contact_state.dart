part of 'contact_bloc.dart';

typedef ContactEntity = List<Contact>;

/// ContactState.
sealed class ContactState extends _ContactStateBase {
  const factory ContactState.idle({
    required ContactEntity data,
    String message,
  }) = ContactStateIdle;

  const factory ContactState.processing({
    required ContactEntity data,
    String message,
  }) = ContactStateProcessing;

  const factory ContactState.successfulFetch({
    required ContactEntity data,
    String message,
  }) = ContactStateSuccessfulFetch;

  const factory ContactState.successfulCreate({
    required ContactEntity data,
    String message,
  }) = ContactStateSuccessfulCreate;

  const factory ContactState.successfulUpdate({
    required ContactEntity data,
    String message,
  }) = ContactStateSuccessfulUpdate;

  const factory ContactState.successfulDelete({
    required ContactEntity data,
    String message,
  }) = ContactStateSuccessfulDelete;

  const factory ContactState.error({
    required ContactEntity data,
    String message,
  }) = ContactStateError;

  const ContactState({required super.data, required super.message});
}

/// Idling state
final class ContactStateIdle extends ContactState with _ContactState {
  const ContactStateIdle({required super.data, super.message = 'Idling'});
}

/// Processing
final class ContactStateProcessing extends ContactState with _ContactState {
  const ContactStateProcessing({required super.data, super.message = 'Processing'});
}

/// Successful
final class ContactStateSuccessfulFetch extends ContactState with _ContactState {
  const ContactStateSuccessfulFetch({required super.data, super.message = 'Successful'});
}

/// Successful create
final class ContactStateSuccessfulCreate extends ContactState with _ContactState {
  const ContactStateSuccessfulCreate({required super.data, super.message = 'Successful'});
}

/// Successful update
final class ContactStateSuccessfulUpdate extends ContactState with _ContactState {
  const ContactStateSuccessfulUpdate({required super.data, super.message = 'Successful'});
}

/// Successful delete
final class ContactStateSuccessfulDelete extends ContactState with _ContactState {
  const ContactStateSuccessfulDelete({required super.data, super.message = 'Successful'});
}

/// Error
final class ContactStateError extends ContactState with _ContactState {
  const ContactStateError({required super.data, super.message = 'An error has occurred.'});
}

base mixin _ContactState on ContactState {}

/// Pattern matching for [ContactState].
typedef ContactStateMatch<R, S extends ContactState> = R Function(S state);

@immutable
abstract base class _ContactStateBase {
  const _ContactStateBase({required this.data, required this.message});

  /// Data entity payload.
  final ContactEntity data;

  /// Message or state description.
  final String message;

  /// Has data
  bool get hasData => data.isNotEmpty;

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
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
