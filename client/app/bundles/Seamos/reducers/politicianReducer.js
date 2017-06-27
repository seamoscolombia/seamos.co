import { SET_POLITICIAN } from '../constants';

const INITIAL_STATE = { };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_POLITICIAN: {
      return Object.assign({}, action.politician);
    }
    default: return state;
  }
};
