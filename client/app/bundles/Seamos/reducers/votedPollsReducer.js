import {
  VOTED_POLLS,
} from '../constants';

// const INITIAL_STATE = [{ //use for reference
//   id: null,
//   title: null,
//   description: null,
//   closing_date: null,
//   poll_image: 'null',
// }];

export default (state = null, action) => {
  switch (action.type) {
    case VOTED_POLLS:
      return action.votedPolls;
    default:
      return state;
  }
};
