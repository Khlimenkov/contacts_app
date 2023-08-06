part of 'feed_bloc.dart';

typedef FeedEntity = List<Contact>;

/// ContactState.
sealed class FeedState extends _ContactStateBase {
  const factory FeedState.idle({
    required FeedEntity data,
    String message,
  }) = FeedStateIdle;

  const factory FeedState.processing({
    required FeedEntity data,
    String message,
  }) = FeedStateProcessing;

  const factory FeedState.successfulFetch({
    required FeedEntity data,
    String message,
  }) = FeedStateSuccessfulFetch;

  const factory FeedState.error({
    required FeedEntity data,
    String message,
  }) = FeedStateError;

  const FeedState({required super.data, required super.message});
}

/// Idling state
final class FeedStateIdle extends FeedState {
  const FeedStateIdle({required super.data, super.message = 'Idling'});
}

/// Processing
final class FeedStateProcessing extends FeedState {
  const FeedStateProcessing({required super.data, super.message = 'Processing'});
}

/// Successful
final class FeedStateSuccessfulFetch extends FeedState {
  const FeedStateSuccessfulFetch({required super.data, super.message = 'Successful'});
}

/// Error
final class FeedStateError extends FeedState {
  const FeedStateError({required super.data, super.message = 'An error has occurred.'});
}

/// Pattern matching for [FeedState].
typedef FeedStateMatch<R, S extends FeedState> = R Function(S state);

@immutable
abstract base class _ContactStateBase {
  const _ContactStateBase({required this.data, required this.message});

  /// Data entity payload.
  final FeedEntity data;

  /// Message or state description.
  final String message;

  /// Has data
  bool get isEmpty => data.isEmpty;

  bool get isNotEmpty => data.isNotEmpty;

  /// If an error has occurred?
  bool get hasError => maybeMap<bool>(orElse: () => false, error: (_) => true);

  /// Is in progress state?
  bool get isProcessing => maybeMap<bool>(orElse: () => false, processing: (_) => true);

  /// Is in idle state?
  bool get isIdling => !isProcessing;

  /// Pattern matching for [FeedState].
  R map<R>({
    required FeedStateMatch<R, FeedStateIdle> idle,
    required FeedStateMatch<R, FeedStateProcessing> processing,
    required FeedStateMatch<R, FeedStateSuccessfulFetch> successfulFetch,
    required FeedStateMatch<R, FeedStateError> error,
  }) =>
      switch (this) {
        FeedStateIdle s => idle(s),
        FeedStateProcessing s => processing(s),
        FeedStateSuccessfulFetch s => successfulFetch(s),
        FeedStateError s => error(s),
        _ => throw AssertionError(),
      };

  /// Pattern matching for [FeedState].
  R maybeMap<R>({
    FeedStateMatch<R, FeedStateIdle>? idle,
    FeedStateMatch<R, FeedStateProcessing>? processing,
    FeedStateMatch<R, FeedStateSuccessfulFetch>? successfulFetch,
    FeedStateMatch<R, FeedStateError>? error,
    required R Function() orElse,
  }) =>
      map<R>(
        idle: idle ?? (_) => orElse(),
        processing: processing ?? (_) => orElse(),
        successfulFetch: successfulFetch ?? (_) => orElse(),
        error: error ?? (_) => orElse(),
      );

  /// Pattern matching for [FeedState].
  R? mapOrNull<R>({
    FeedStateMatch<R, FeedStateIdle>? idle,
    FeedStateMatch<R, FeedStateProcessing>? processing,
    FeedStateMatch<R, FeedStateSuccessfulFetch>? successfulFetch,
    FeedStateMatch<R, FeedStateError>? error,
  }) =>
      map<R?>(
        idle: idle ?? (_) => null,
        processing: processing ?? (_) => null,
        successfulFetch: successfulFetch ?? (_) => null,
        error: error ?? (_) => null,
      );

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) => identical(this, other);
}
