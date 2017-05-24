import { combineReducers } from 'redux';
import PollReducer from './pollReducer';
import PollsReducer from './pollsReducer';
import VotedDebateReducer from './votedDebateReducer';
import VotedPollReducer from './votedPollReducer';
import VotedPollsReducer from './votedPollsReducer';
import SwiperReducer from './swiperReducer';

export default combineReducers({
  actualPoll: PollReducer,
  actualVotedDebate: VotedDebateReducer,
  actualVotedPoll: VotedPollReducer,
  polls: PollsReducer,
  votedPolls: VotedPollsReducer,
  swiper: SwiperReducer,
});
