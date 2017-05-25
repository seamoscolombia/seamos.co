import pollsReducer from '../../app/bundles/Seamos/reducers/pollsReducer';
import { UPDATE_POLLS } from '../../app/bundles/Seamos/constants/';
import { pollsMock } from '../__mocks__/polls';

const myInitialState = [{
    already_voted: false,
    description: "El alex y sus propuestas",
    id: 1,
    title: "El Alex",
    type: null,
}]
describe('pollsReducers test',()=>{

    it(`+++ reducer for ${UPDATE_POLLS}`, () => {
        const state = pollsReducer(myInitialState, {type: UPDATE_POLLS, polls: pollsMock })
        expect(state).toEqual(pollsMock);
    });
});