import { RESET_SESSION, SET_SESSION } from '../constants';

export default (state = undefined, action) => {
  switch (action.type) {
    case SET_SESSION:
      return action.authenticityToken;
    case RESET_SESSION:
      return null;
    default:
      return state;
  }
};
