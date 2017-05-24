import {
  SET_VOTED_POLL,
  SET_VOTE_RESULTS
} from '../constants';

const INITIAL_STATE = { id: null, results: null };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_VOTED_POLL:
      return { ...state, id: action.votedPollId };
    case SET_VOTE_RESULTS:
      return { ...state, results: action.vote_types, chart_type: action.chart_type };
    default:
      return state;
  }
};
