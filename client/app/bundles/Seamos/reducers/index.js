import { combineReducers } from 'redux';
import PollReducer from './pollReducer';
import PollsReducer from './pollsReducer';
import VotedPollReducer from './votedPollReducer';
import VotedPollsReducer from './votedPollsReducer';

export default combineReducers({
  actualPoll: PollReducer,
  actualVotedPoll: VotedPollReducer,
  polls: PollsReducer,
  votedPolls: VotedPollsReducer,
});
