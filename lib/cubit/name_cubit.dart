import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'name_state.dart';

class NameCubit extends Cubit<String> {
 
 

  // ignore: non_constant_identifier_names
  login(Username,channel) {
  
    emit(Username);
    channel.sink.add('{"type": "sign_in", "data": {"name": "$Username"}}');

}
NameCubit() : super('');

}
