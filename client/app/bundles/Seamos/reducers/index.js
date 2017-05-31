import { combineReducers } from 'redux';
import PollDetailReducer from './pollDetailReducer';
import PollsReducer from './pollsReducer';
import user from './userReducer';
import VotedPollReducer from './votedPollReducer';
import VotedPollsReducer from './votedPollsReducer';

export default combineReducers({
  PollDetailReducer,
  actualVotedPoll: VotedPollReducer,
  polls: PollsReducer,
  user,
  votedPolls: VotedPollsReducer,
});
