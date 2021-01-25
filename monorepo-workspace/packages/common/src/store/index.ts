import {
  Action,
  configureStore,
  Dispatch,
  getDefaultMiddleware,
  Middleware,
  MiddlewareAPI,
  ReducersMapObject,
  ThunkAction
} from "@reduxjs/toolkit";
import { combineReducers } from "@reduxjs/toolkit";
import createSagaMiddleware from "redux-saga";
import { all } from "redux-saga/effects";

import { LOADING, loadingReducer } from "./loading";

const sagaMiddleware = createSagaMiddleware();

function* rootSaga() {
  yield all([]);
}

export const createStore = () => {
  const store = configureStore({
    reducer: rootReducer,
    devTools: true,
    middleware: [...getDefaultMiddleware(), sagaMiddleware, persistMiddleware]
  });
  sagaMiddleware.run(rootSaga);

  return store;
};

const rootReducer = combineReducers({
  [LOADING]: loadingReducer
  // add reducer
} as ReducersMapObject);

const persistMiddleware: Middleware = ({ getState }: MiddlewareAPI) => (
  next: Dispatch
) => action => {
  console.log(getState);
  const returnValue = next(action);

  return returnValue;
};

export type IRootState = ReturnType<typeof rootReducer>;
export type AppThunk = ThunkAction<void, IRootState, unknown, Action<string>>;
