import { UPDATE_TAG } from '../constants';
const INITIAL_STATE = {};

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case UPDATE_TAG:
      return Object.assign({}, ...state, action.tag);
    default:
      return state;
  }
};
