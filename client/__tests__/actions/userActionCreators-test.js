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

  describe('async actions', () => {
    beforeEach(() => {
      // import and pass your custom axios instance to this method
      moxios.install();
    });

    afterEach(() => {
      // import and pass your custom axios instance to this method
      moxios.uninstall();
    });

    it('validate user is register in platform', () => {
       moxios.stubRequest(`${API_END_POINT}/sessions.jso`, {
        status: 200,
        response: { data: { authenticityToken: 'authenticityToken' } }
      });  
      const store = mockStore({ user: {} });
      const expectedActions = { type: SET_USER };
      store.dispatch(actions.validateUserSession(fbUserMock))
        .then(() => { // return of async actions
          expect(store.getActions()).toEqual(expectedActions);
        }); 
    });
  });
});

