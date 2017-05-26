import UserReducer from '../../app/bundles/Seamos/reducers/userReducer';
import { UPDATE_USER } from '../../app/bundles/Seamos/constants/';
import { userMock } from '../__mocks__/tags';
/*
User's full name (fb)
User's location (fb)
User's participations (Hash)
    count
    polls
        id
        title
        remaining days (seconds)
User's interests count
*/
const myInitialState = {
    id: null,
    full_name: null, 
    location: null,
    interests_count: null,
    participations: { 
        count: 0, polls: [{ id: null, title: null, remaining: null }]
    },
    authenticity_token: null
};

describe('Usereducers test', () => {
    it('update tags', () => {
        const state = UserReducer(myInitialState, { type: UPDATE_USER, user: userMock });
        expect(state).toEqual(userMock);
    });
});
