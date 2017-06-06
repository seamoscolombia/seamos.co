import { combineReducers } from 'redux';
import poll from './pollDetailReducer';
import polls from './pollsReducer';
import user from './userReducer';
import session from './sessionReducer';
import tags from './tagsReducer';
import VotedPollReducer from './votedPollReducer';
import VotedPollsReducer from './votedPollsReducer';

export default combineReducers({
  poll,
  actualVotedPoll: VotedPollReducer,
  polls,
  user,
  session,
  tags,
  votedPolls: VotedPollsReducer,
});
