import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'board_state.dart';

class BoardCubit extends Cubit<BoardState> {
  BoardCubit() : super(BoardInitial.initial());

  void setBoard(double density, int width, int height) =>
      emit(BoardInitial(density, width, height));
}
