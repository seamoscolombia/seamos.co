import { UPDATE_POLL } from '../constants';

const INITIAL_STATE = {
  id: null,
  title: null,
  image: null,
  description: null,
  objective: null,
  initial_time: null,
  remaining: null,
  vote_count: null,
  already_voted: null,
  links: [],
  politician: {
    id: null,
    full_name: null
  }
};

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case UPDATE_POLL:
      return Object.assign({}, action.poll);
    default:
      return state;
  }
};
