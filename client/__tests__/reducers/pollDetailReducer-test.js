import pollDetailReducer from '../../app/bundles/Seamos/reducers/pollDetailReducer';
import { UPDATE_POLL } from '../../app/bundles/Seamos/constants';
import { pollMock } from '../__mocks__/poll.js';

const myInitialState = {
  id: null,
  title: null,
  image: null,
  description: null,
  objective: null,
  remaining: null,
  vote_count: null,
  already_voted: false,
  links: [],
  politician: {
    id: null,
    full_name: null
  }
}

describe('pollDetailReducers test',()=>{
  it('updates the state', () => {
    const state = pollDetailReducer( myInitialState, {type: UPDATE_POLL, poll: pollMock} )
    expect( state ).toEqual( pollMock );
  });
});
