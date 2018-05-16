import {
  RESULT_POLLS,
  UPDATE_POLLS
} from '../constants';


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
    case UPDATE_POLLS:
      return Object.assign([], ...state, action.polls);
    default:
      return state;
  }
};
