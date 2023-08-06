part of 'feed_bloc.dart';

sealed class FeedEvent extends _ContactEventBase {
  const FeedEvent();

  /// Fetch
  const factory FeedEvent.fetch() = FetchFeedEvent;

  const factory FeedEvent.init() = InitFeedEvent;
}

final class FetchFeedEvent extends FeedEvent with _ContactEvent {
  const FetchFeedEvent();
}

final class InitFeedEvent extends FeedEvent with _ContactEvent {
  const InitFeedEvent();
}

base mixin _ContactEvent on FeedEvent {}

/// Pattern matching for [FeedEvent].
typedef FeedEventMatch<R, S extends FeedEvent> = R Function(S state);

abstract base class _ContactEventBase {
  const _ContactEventBase();

  /// Pattern matching for [FeedState].
  R map<R>({
    required FeedEventMatch<R, FetchFeedEvent> fetch,
    required FeedEventMatch<R, InitFeedEvent> init,
  }) =>
      switch (this) {
        FetchFeedEvent e => fetch(e),
        InitFeedEvent e => init(e),
        _ => throw AssertionError(),
      };
}
