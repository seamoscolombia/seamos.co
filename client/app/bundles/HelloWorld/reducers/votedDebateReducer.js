import { SET_VOTE_DEBATE_RESULTS } from '../constants';

const INITIAL_STATE = { id: null, results: null };

export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_VOTE_DEBATE_RESULTS:
      //console.log('SET_VOTE_DEBATE_RESULTS');
      return { ...state, results: action.vote_types };
    default:
      return state;
  }
};
