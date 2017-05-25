import pollReducer from '../../app/bundles/Seamos/reducers/pollReducer';
import { SET_POLL, UPDATE_POLL, VALIDATE_ACTUAL_POLL } from '../../app/bundles/Seamos/constants';

describe('pollReducers test',()=>{
    it(`+++ reducer for ${SET_POLL}`, () => {
        let state = {id: 1, alreadyVoted: true}
        state = pollReducer(state,{type: SET_POLL, poll: 1 })
        expect(state).toEqual({ id: 1, alreadyVoted: false });
    });

});