import { combineReducers } from 'redux';
import interests from './interestsReducer';
import politician from './politicianReducer';
import poll from './pollDetailReducer';
import polls from './pollsReducer';
import user from './userReducer';
import tag from './tagReducer';
import session from './sessionReducer';
import tags from './tagsReducer';
import VotedPollReducer from './votedPollReducer';
import VotedPollsReducer from './votedPollsReducer';
import railsReducer from './railsReducer';
import pollIdReducer from './pollIdReducer';

export default combineReducers({
  interests,
  poll,
  politician,
  actualVotedPoll: VotedPollReducer,
  polls,
  user,
  session,
  tag,
  tags,
  votedPolls: VotedPollsReducer,
  railsReducer,
  pollIdReducer
});
