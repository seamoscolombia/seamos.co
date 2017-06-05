import { RESET_SESSION, SET_SESSION } from '../constants';

const INITIAL_STATE = localStorage.getItem('session') ? JSON.parse(localStorage.getItem('session')) : { authenticityToken: null };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_SESSION: {
      const session = Object.assign({}, { authenticityToken: action.authenticityToken });
      localStorage.setItem('session', JSON.stringify(session));
      return session;
    }
    case RESET_SESSION: {
      localStorage.removeItem('session');
      return { authenticityToken: null };
    }
    default:
      return state;
  }
};
