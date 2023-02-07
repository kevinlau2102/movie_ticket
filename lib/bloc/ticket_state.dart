part of 'ticket_bloc.dart';

@freezed
class TicketState with _$TicketState {
  const factory TicketState.initial() = _Initial;
  const factory TicketState.running(Ticket ticket) = _Running;
}
