import pollsReducer from '../../app/bundles/Seamos/reducers/pollsReducer';
import { UPDATE_POLLS } from '../../app/bundles/Seamos/constants/';
import { pollsMock } from '../__mocks__/polls';

const myInitialState = [{
    already_voted: null,
    description: null,
    id: null,
    title: null,
    type: null
}]
describe('pollsReducers test',()=>{

    it(`+++ reducer for ${UPDATE_POLLS}`, () => {
        const state = pollsReducer(myInitialState, {type: UPDATE_POLLS, polls: pollsMock })
        expect(state).toEqual(pollsMock);
    });
});