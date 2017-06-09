import tagsReducer from '../../app/bundles/Seamos/reducers/tagsReducer';
import { UPDATE_TAGS } from '../../app/bundles/Seamos/constants/';
import { tagsMock } from '../__mocks__/tags';

const myInitialState = [{ name: null, image: null }];

describe('tagsReducers test', () => {
    it('update tags', () => {
        const state = tagsReducer(myInitialState, { type: UPDATE_TAGS, tags: tagsMock });
        expect(state).toEqual(tagsMock);
    });
});
