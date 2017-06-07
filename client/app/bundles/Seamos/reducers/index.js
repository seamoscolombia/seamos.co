import { combineReducers } from 'redux';
import poll from './pollDetailReducer';
import polls from './pollsReducer';
import user from './userReducer';
import tag from './tagReducer';
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
  tag,
  tags,
  votedPolls: VotedPollsReducer,
});
