import { UPDATE_TAG } from '../constants';
const INITIAL_STATE = {
  tag_image: null,
  tag_icon: null,
  tag_color: null,
  tag_name: null
};

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case UPDATE_TAG:
      return Object.assign({}, state, action.tag);
    default:
      return state;
  }
};
