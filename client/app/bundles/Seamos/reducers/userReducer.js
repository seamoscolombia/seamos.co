import {
  DELETE_TAGS_ON_USER, RESET_SESSION, SET_USER, ADD_TAGS_ON_USER
} from '../constants';

const INITIAL_STATE = localStorage.getItem('user') ? //eslint-disable-line
  JSON.parse(localStorage.getItem('user')) //eslint-disable-line
  : { };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case RESET_SESSION: {
      localStorage.removeItem('user');
      return { };
    }
    case SET_USER: {
      const user = Object.assign({}, state, action.user);
      localStorage.setItem('user', JSON.stringify(user)); //eslint-disable-line
      return user;
    }
    case ADD_TAGS_ON_USER: {
      state.tags.push(action.tag);
      const user = Object.assign({}, state);
      localStorage.setItem('user', JSON.stringify(user)); //eslint-disable-line
      return user;
    }
    case DELETE_TAGS_ON_USER: {
      const tagIndex = state.tags.findIndex(tag => tag.tag_id === action.tag.tag_id);
      state.tags.splice(tagIndex, 1);
      const user = Object.assign({}, state);
      localStorage.setItem('user', JSON.stringify(user)); //eslint-disable-line
      return user;
    }

    default: return state;
  }
};
