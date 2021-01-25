import { createSlice, PayloadAction } from '@reduxjs/toolkit';

const name = 'Loading';

export interface IState {
  [key: string]: boolean;
}

const initialState: IState = {};

const _ = createSlice({
  name,
  initialState,
  reducers: {
    start(state: IState, { payload }: PayloadAction<string>) {
      state[payload] = true;
    },
    end(state: IState, { payload }: PayloadAction<string>) {
      state[payload] = false;
    },
  },
});

export const LOADING = _.name;
export const loadingActions = _.actions;
export const loadingReducer = _.reducer;
