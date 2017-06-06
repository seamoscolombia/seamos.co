import { UPDATE_TAG } from '../constants';
const INITIAL_STATE = null

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case UPDATE_TAG:
      return Object.assign({}, action.tag);
    default:
      return state;
  }
};
