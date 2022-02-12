import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../config/shared_preferences_config.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SharedPreferencesConfig? sharedPreferencesConfig;

  AppBloc({this.sharedPreferencesConfig}) : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    /*  if (event is AppAddNoteTypeWithDeadLine) {
      sharedPreferencesConfig.noteListWithDeadline.add(
          Note(message: event.message, date: event.date, type: event.type));
      sharedPreferencesConfig.setNotes(event.type);
      yield AppNoteRegistred();
    } else if (event is AppAddNoteTypeImportant) {
      sharedPreferencesConfig.noteLisimportant.add(
          Note(message: event.message, date: event.date, type: event.type));
      sharedPreferencesConfig.setNotes(event.type);
      yield AppNoteRegistred();
    }*/
  }
}
