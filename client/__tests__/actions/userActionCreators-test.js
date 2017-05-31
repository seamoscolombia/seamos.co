import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import axios from 'axios';
import moxios from 'moxios';

import * as actions from '../../app/bundles/Seamos/actions';
import { SET_USER, URL } from '../../app/bundles/Seamos/constants';


const API_END_POINT = URL || 'http://example.com';
const middlewares = [thunk];
const mockStore = configureMockStore(middlewares);
const fbUserMock = {
  id: 1, 
  accessToken: 'accessToken',
  first_name: 'first_name',
  last_name: 'last_name',
  email: 'email@email.com'
};

describe('users actions', () => {
  it('should set a user', () => {
    const expectedAction = { type: SET_USER };
    expect(actions.setUser()).toEqual(expectedAction);
  });


});

