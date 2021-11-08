import 'package:bloc/bloc.dart';


class cubit_controller extends Cubit<String> {
 
 

  login(Uname,channel) {
  
    emit(Uname);
    channel.sink.add('{"type": "sign_in", "data": {"name": "$Uname"}}');

}
cubit_controller() : super('');

}
