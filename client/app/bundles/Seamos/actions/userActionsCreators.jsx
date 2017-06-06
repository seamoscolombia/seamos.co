/* eslint-disable import/prefer-default-export */
/* eslint-disable window.localStorage */

import axios from 'axios';
import { SET_USER, RESET_SESSION, URL } from '../constants';
import { setSession } from './sessionActionsCreators';

export const createUser = (fbUser, authenticityToken) => dispatch => {
  const user = {
    names: fbUser.first_name,
    first_surname: fbUser.last_name,
    second_surname: 'N.A.',
    email: fbUser.email
  };
  axios.post(`${URL}/users.json`, {
    authenticity_token: authenticityToken, //eslint-disable-line
    user
  })
  .then(response => {
    response.data.user.picture = fbUser.picture.data.url;
    response.data.user.location = fbUser.location ? fbUser.location.name : null;
    dispatch(setUser(response.data.user));
    dispatch(setSession(response.data.user.authenticity_token));
  })
  .catch(e => {
    alert('Ah ocurrido un error por favor reporta a nuestro equipo');
  });
};

export const getUser = (fbUser) => (dispatch) => {
  axios.get(`${URL}/profile.json`)
    .then(response => {
      response.data.user.picture = fbUser.picture.data.url;
      response.data.user.location = fbUser.location ? fbUser.location.name : null;
      dispatch(setUser(response.data.user));
    })
    .catch(e => {
      alert('Ah ocurrido un error por favor reporta a nuestro equipo');
    });
};

export const setUser = (user) => ({
  type: SET_USER,
  user
});

export const resetUser = () => ({ type: RESET_SESSION });

export const validateUserSession = (fbUser) => (dispatch) => (
  axios.post(`${URL}/sessions.json`, {
    uid: fbUser.id,
    fb_token: fbUser.accessToken
  })
  .then(response => {
    dispatch(setSession(response.data.authenticity_token));
    dispatch(getUser(fbUser));
  })
  .catch(e => {
    if (e.response && e.response.status === 422) {
      dispatch(createUser(fbUser, e.response.data.authenticity_token));
    } else {
      console.warn('Error != 422');
      console.warn(e);
      if (!e.response) {
        throw e;
      }
      alert('Ah ocurrido un error por favor reporta a nuestro equipo');
    }
  })
);
