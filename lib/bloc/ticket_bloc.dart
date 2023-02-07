import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:movie_app/entities/ticket.dart';

part 'ticket_event.dart';
part 'ticket_state.dart';
part 'ticket_bloc.freezed.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(const _Initial()) {
    Ticket ticket = Ticket();
    on<TicketEvent>((event, emit) {
      emit(state.when(
          initial: () => TicketState.running(ticket),
          running: (Ticket ticket) {
            return event.when(
                started: (ticket) =>
                    TicketState.running(ticket),
                historyTicket: (Ticket ticket) {
                  return TicketState.running(ticket);
                });
          }));
    });
  }
}
