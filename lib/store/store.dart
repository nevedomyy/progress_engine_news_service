import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';
import '../reducer/reducer.dart';
import 'state.dart';


final store = Store<AppState>(
  reducer,
  initialState: AppState.initial(),
  middleware: [thunkMiddleware]
);