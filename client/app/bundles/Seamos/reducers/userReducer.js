import { SET_USER, RESET_SESSION } from '../constants';

const INITIAL_STATE = localStorage.getItem('user') ? //eslint-disable-line
  JSON.parse(localStorage.getItem('user')) //eslint-disable-line
  : { }; 
  
export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_USER: {
      const user = Object.assign({}, state, action.user);
      localStorage.setItem('user', JSON.stringify(user)); //eslint-disable-line
      return user;
    }
    case RESET_SESSION: return { };
    default: return state;
  }
};
