import { RESET_SESSION, SET_SESSION } from '../constants';

const INITIAL_STATE = { authenticityToken: null };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_SESSION:
      return Object.assign({}, { authenticityToken: action.authenticityToken });
    case RESET_SESSION:
      return { authenticityToken: null };
    default:
      return state;
  }
};
