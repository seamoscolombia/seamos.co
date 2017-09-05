import { RESET_SESSION, SET_SESSION, IS_LOGGED } from '../constants';

const INITIAL_STATE = localStorage.getItem('session') ? JSON.parse(localStorage.getItem('session')) // eslint-disable-line
  : { authenticityToken: null };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_SESSION: {
      const session = Object.assign({}, state, { authenticityToken: action.authenticityToken });
      localStorage.setItem('session', JSON.stringify(session));// eslint-disable-line
      return session;
    }
    case RESET_SESSION: {
      localStorage.removeItem('session');// eslint-disable-line
      sessionStorage.clear();// eslint-disable-line
      return { authenticityToken: null };
    }
    case IS_LOGGED: {
      const session = Object.assign({}, state, { logged: action.logged });
      return session;
    }
    default:
      return state;
  }
};
