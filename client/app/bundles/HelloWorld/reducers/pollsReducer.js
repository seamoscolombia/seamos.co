import {
  INDEX_POLLS,
  RESULT_POLLS,
  UPDATE_POLLS
} from '../constants';

import { TVTDURL } from '../constants';

// const INITIAL_STATE = [{ //use for reference
//   id: null,
//   title: null,
//   description: null,
//   closing_date: null,
//   poll_image: 'null',
//   vote_types: [{ id: null, name: 'null' }]
// }];

export default (state = [], action) => {
  switch (action.type) {
    case INDEX_POLLS:
      return action.polls;
    case RESULT_POLLS:
      return { ...state, url: `${TVTDURL}polls/voted` };
    case UPDATE_POLLS:
      return Object.assign([], state, action.polls);
    default:
      return state;
  }
};
