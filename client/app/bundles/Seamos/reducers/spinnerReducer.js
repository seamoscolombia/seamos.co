import { SHOW_SPINNER, HIDE_SPINNER } from '../constants';

const INITIAL_STATE = { isFetching: false };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SHOW_SPINNER:
      return { ...state, isFetching: true };
    case HIDE_SPINNER:
      return { ...state, isFetching: false };
    default:
      return state;
  }
};
