import { SET_POLITICIAN } from '../constants';

const INITIAL_STATE = {
  id: null,
  full_name: null,
  short_name: null,
  organization: null,
  bio: null,
  polls: [ {
      id: null,
      title: null,
      description: null,
      type: null,
      poll_image: null,
      vote_count: null,
      remaining: null,
      tag: { color: null }
  }],
  closed_polls: [{
      id: null,
      title: null,
      description: null,
      type: null,
      poll_image: null,
      vote_count: null,
      remaining: null,
      tag: { color: null }
  }],
  authenticity_token: null
};

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_POLITICIAN: {
      return Object.assign({}, ...state, action.politician);
    }
    default: return state;
  }
};
