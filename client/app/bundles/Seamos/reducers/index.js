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
import inputReducer from './inputReducer';
import newsletterReducer from './newsletterReducer';
import pollIdReducer from './pollIdReducer';
import mayInterestReducer from './mayInterestReducer';

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
  inputReducer,
  newsletterReducer,
  pollIdReducer,
  mayInterestReducer
});
