import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expenses_repository/expense_repository.dart';
import 'package:expenses_repository/src/models/category.dart';
part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  ExpenseRepository expenseRepository;

  GetCategoryBloc(this.expenseRepository) : super(GetCategoryInitial()) {
    on<GetCategory>((event, emit) async {
      emit(GetCategoryLoading());
      try {
        List<Category> categories = await expenseRepository.getCategory();
        emit(GetCategorySuccess(categories));
      } catch (e) {
        emit(GetCategoryFailure());
      }
    });
  }
}
