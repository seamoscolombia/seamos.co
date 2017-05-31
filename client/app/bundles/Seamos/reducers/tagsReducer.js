import { UPDATE_TAGS } from '../constants';

export default (state = [], action) => {
  switch (action.type) {
    case UPDATE_TAGS:
      return action.tags;
    default:
      return state;
  }
};
