part of 'ticket_bloc.dart';

@freezed
class TicketEvent with _$TicketEvent {
  const factory TicketEvent.started(Ticket ticket) = _Started;
  const factory TicketEvent.historyTicket(Ticket ticket) = _Ticket;
}