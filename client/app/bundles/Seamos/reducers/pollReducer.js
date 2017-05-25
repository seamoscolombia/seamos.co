import {
  SET_POLL,
  UPDATE_POLL,
  VALIDATE_ACTUAL_POLL
} from '../constants';

const INITIAL_STATE = {
  id: null, already_voted: false
};

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_POLL:
      return { ...state, id: action.poll, alreadyVoted: false };
    case UPDATE_POLL:
      return { ...state, id: action.poll.id, alreadyVoted: true };
    case VALIDATE_ACTUAL_POLL:
      const { polls } = action;
      const pollArray = polls.filter(pollI => pollI.id === state.id);
      console.log(`VALIDATE_ACTUAL_POLL: ${JSON.stringify(pollArray)}`);
      if (pollArray.length === 0 || pollArray[0]) {
        return state;
      }

      return { ...state, id: polls[0].id, alreadyVoted: false };
    default:
      return state;
  }
};
