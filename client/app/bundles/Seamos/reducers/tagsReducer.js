import { UPDATE_TAGS } from '../constants';

export default (state = [], action) => {
  switch (action.type) {
    case UPDATE_TAGS:
      return Object.assign([], state, action.tags);
    default:
      return state;
  }
};
