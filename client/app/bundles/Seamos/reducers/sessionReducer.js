import { RESET_SESSION, SET_USER, SET_SESSION, IS_LOGGED, TOASTER_DISPLAY } from '../constants';

const INITIAL_STATE = localStorage.getItem('session') ? JSON.parse(localStorage.getItem('session')) // eslint-disable-line
  : { authenticityToken: null, logged: null, display: false };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_SESSION: {
      const session = Object.assign({}, state, { authenticityToken: action.authenticityToken });
      localStorage.setItem('session', JSON.stringify(session));// eslint-disable-line
      return session;
    }
    case SET_USER: {
      const session = Object.assign({}, state, { authenticityToken: action.user.authenticity_token });
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
    case TOASTER_DISPLAY: {
      const session = Object.assign({}, state, { display: true });
      return session;
    }
    default:
      return state;
  }
};
