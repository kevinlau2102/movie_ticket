// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TicketEvent {
  Ticket get ticket => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Ticket ticket) started,
    required TResult Function(Ticket ticket) historyTicket,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Ticket ticket)? started,
    TResult? Function(Ticket ticket)? historyTicket,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Ticket ticket)? started,
    TResult Function(Ticket ticket)? historyTicket,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Ticket value) historyTicket,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Ticket value)? historyTicket,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Ticket value)? historyTicket,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TicketEventCopyWith<TicketEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketEventCopyWith<$Res> {
  factory $TicketEventCopyWith(
          TicketEvent value, $Res Function(TicketEvent) then) =
      _$TicketEventCopyWithImpl<$Res, TicketEvent>;
  @useResult
  $Res call({Ticket ticket});
}

/// @nodoc
class _$TicketEventCopyWithImpl<$Res, $Val extends TicketEvent>
    implements $TicketEventCopyWith<$Res> {
  _$TicketEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticket = null,
  }) {
    return _then(_value.copyWith(
      ticket: null == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as Ticket,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> implements $TicketEventCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ticket ticket});
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res>
    extends _$TicketEventCopyWithImpl<$Res, _$_Started>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticket = null,
  }) {
    return _then(_$_Started(
      null == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as Ticket,
    ));
  }
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started(this.ticket);

  @override
  final Ticket ticket;

  @override
  String toString() {
    return 'TicketEvent.started(ticket: $ticket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Started &&
            (identical(other.ticket, ticket) || other.ticket == ticket));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ticket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StartedCopyWith<_$_Started> get copyWith =>
      __$$_StartedCopyWithImpl<_$_Started>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Ticket ticket) started,
    required TResult Function(Ticket ticket) historyTicket,
  }) {
    return started(ticket);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Ticket ticket)? started,
    TResult? Function(Ticket ticket)? historyTicket,
  }) {
    return started?.call(ticket);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Ticket ticket)? started,
    TResult Function(Ticket ticket)? historyTicket,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(ticket);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Ticket value) historyTicket,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Ticket value)? historyTicket,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Ticket value)? historyTicket,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements TicketEvent {
  const factory _Started(final Ticket ticket) = _$_Started;

  @override
  Ticket get ticket;
  @override
  @JsonKey(ignore: true)
  _$$_StartedCopyWith<_$_Started> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_TicketCopyWith<$Res> implements $TicketEventCopyWith<$Res> {
  factory _$$_TicketCopyWith(_$_Ticket value, $Res Function(_$_Ticket) then) =
      __$$_TicketCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Ticket ticket});
}

/// @nodoc
class __$$_TicketCopyWithImpl<$Res>
    extends _$TicketEventCopyWithImpl<$Res, _$_Ticket>
    implements _$$_TicketCopyWith<$Res> {
  __$$_TicketCopyWithImpl(_$_Ticket _value, $Res Function(_$_Ticket) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticket = null,
  }) {
    return _then(_$_Ticket(
      null == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as Ticket,
    ));
  }
}

/// @nodoc

class _$_Ticket implements _Ticket {
  const _$_Ticket(this.ticket);

  @override
  final Ticket ticket;

  @override
  String toString() {
    return 'TicketEvent.historyTicket(ticket: $ticket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Ticket &&
            (identical(other.ticket, ticket) || other.ticket == ticket));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ticket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      __$$_TicketCopyWithImpl<_$_Ticket>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Ticket ticket) started,
    required TResult Function(Ticket ticket) historyTicket,
  }) {
    return historyTicket(ticket);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Ticket ticket)? started,
    TResult? Function(Ticket ticket)? historyTicket,
  }) {
    return historyTicket?.call(ticket);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Ticket ticket)? started,
    TResult Function(Ticket ticket)? historyTicket,
    required TResult orElse(),
  }) {
    if (historyTicket != null) {
      return historyTicket(ticket);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_Ticket value) historyTicket,
  }) {
    return historyTicket(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_Ticket value)? historyTicket,
  }) {
    return historyTicket?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_Ticket value)? historyTicket,
    required TResult orElse(),
  }) {
    if (historyTicket != null) {
      return historyTicket(this);
    }
    return orElse();
  }
}

abstract class _Ticket implements TicketEvent {
  const factory _Ticket(final Ticket ticket) = _$_Ticket;

  @override
  Ticket get ticket;
  @override
  @JsonKey(ignore: true)
  _$$_TicketCopyWith<_$_Ticket> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$TicketState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Ticket ticket) running,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Ticket ticket)? running,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Ticket ticket)? running,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketStateCopyWith<$Res> {
  factory $TicketStateCopyWith(
          TicketState value, $Res Function(TicketState) then) =
      _$TicketStateCopyWithImpl<$Res, TicketState>;
}

/// @nodoc
class _$TicketStateCopyWithImpl<$Res, $Val extends TicketState>
    implements $TicketStateCopyWith<$Res> {
  _$TicketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$TicketStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'TicketState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Ticket ticket) running,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Ticket ticket)? running,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Ticket ticket)? running,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements TicketState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$$_RunningCopyWith<$Res> {
  factory _$$_RunningCopyWith(
          _$_Running value, $Res Function(_$_Running) then) =
      __$$_RunningCopyWithImpl<$Res>;
  @useResult
  $Res call({Ticket ticket});
}

/// @nodoc
class __$$_RunningCopyWithImpl<$Res>
    extends _$TicketStateCopyWithImpl<$Res, _$_Running>
    implements _$$_RunningCopyWith<$Res> {
  __$$_RunningCopyWithImpl(_$_Running _value, $Res Function(_$_Running) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticket = null,
  }) {
    return _then(_$_Running(
      null == ticket
          ? _value.ticket
          : ticket // ignore: cast_nullable_to_non_nullable
              as Ticket,
    ));
  }
}

/// @nodoc

class _$_Running implements _Running {
  const _$_Running(this.ticket);

  @override
  final Ticket ticket;

  @override
  String toString() {
    return 'TicketState.running(ticket: $ticket)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Running &&
            (identical(other.ticket, ticket) || other.ticket == ticket));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ticket);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RunningCopyWith<_$_Running> get copyWith =>
      __$$_RunningCopyWithImpl<_$_Running>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(Ticket ticket) running,
  }) {
    return running(ticket);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(Ticket ticket)? running,
  }) {
    return running?.call(ticket);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(Ticket ticket)? running,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(ticket);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Running value) running,
  }) {
    return running(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Running value)? running,
  }) {
    return running?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Running value)? running,
    required TResult orElse(),
  }) {
    if (running != null) {
      return running(this);
    }
    return orElse();
  }
}

abstract class _Running implements TicketState {
  const factory _Running(final Ticket ticket) = _$_Running;

  Ticket get ticket;
  @JsonKey(ignore: true)
  _$$_RunningCopyWith<_$_Running> get copyWith =>
      throw _privateConstructorUsedError;
}
