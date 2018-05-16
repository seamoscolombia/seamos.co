/* eslint-disable import/prefer-default-export */
/* eslint-disable window.localStorage */

import axios from 'axios';
import { ADD_TAGS_ON_USER, DELETE_TAGS_ON_USER, SET_USER, RESET_SESSION, URL, 
  IS_LOGGED } from '../constants';
import { setSession } from './sessionActionsCreators';
import { getInterests } from './tagsActionsCreators';

export const addTagsOnUser = (tag) => ({
  type: ADD_TAGS_ON_USER,
  tag,
});

export const deleteTagsOnUser = (tag) => ({
  type: DELETE_TAGS_ON_USER,
  tag,
});

export const createUser = (loginResponse, authenticityToken) => dispatch => {
  const user = {
    names: loginResponse.first_name || loginResponse.profileObj.givenName,
    first_surname: loginResponse.last_name || loginResponse.profileObj.familyName,
    second_surname: 'N.A.',
    email: loginResponse.email  || loginResponse.profileObj.email
  };
  axios.post(`${URL}/users.json`, {
    authenticity_token: authenticityToken, //eslint-disable-line
    user
  })
    .then(response => {
      response.data.user.picture = loginResponse.picture ? loginResponse.picture.data.url : loginResponse.profileObj.imageUrl;
      response.data.user.location = loginResponse.location ? loginResponse.location.name : null;
      dispatch(setUser(response.data.user));
      dispatch(setSession(response.data.user.authenticity_token));
      location.reload();      
    })
    .catch(e => {
      alert('Por favor inicia sesión nuevamente');
    });
};

export const getUser = () => (dispatch) => (
  axios.get(`${URL}/profile.json`)
    .then(response => {
      dispatch(setUser(response.data.user));
    })
    .catch(e => {
    })
);

export const setUser = (user) => ({
  type: SET_USER,
  user
});

export const resetUser = () => ({ type: RESET_SESSION });

export const validateUserSession = (loginResponse) => (dispatch) => (
  axios.post(`${URL}/sessions.json`, {
    uid: loginResponse.id || loginResponse.profileObj.googleId,
    login_token: loginResponse.accessToken,
    login_image: loginResponse.picture ? loginResponse.picture.data.url : loginResponse.profileObj.imageUrl,
    login_location: loginResponse.location ? loginResponse.location.name : null
  })
    .then(response => {
      dispatch(setSession(response.data.authenticity_token));
      dispatch(getUser(loginResponse));
      dispatch(setUserEmail(loginResponse, response.data.authenticity_token));
    })
    .catch(e => {
      if (e.response && e.response.status === 422) {
        dispatch(createUser(loginResponse, e.response.data.authenticity_token));
      } else {
        console.warn('Error != 422');
        console.warn(e);
        if (!e.response) {
          throw e;
        }
        alert('Por favor inicia sesión nuevamente');
      }
    })
  );

export const setUserEmail = (loginResponse, authenticityToken) => (dispatch) => (
  axios.post(`/set_user_email.json`, {
    email: loginResponse.email  || loginResponse.profileObj.email,
    authenticity_token: authenticityToken
  })
);

export const userInterests = ({ authenticity_token, user_id, tag }) => (dispatch) => (
  axios.post(`${URL}/users/${user_id}/interests`, {
    authenticity_token, tag_id: tag.id
  })
    .then((response) => {
      switch (response.status) {
        case 201:
          dispatch(addTagsOnUser(tag));
          dispatch(getInterests(user_id));
          break;
        case 204:
          dispatch(deleteTagsOnUser(tag));
          dispatch(getInterests(user_id));
          break;
        default:
          break;
      }
    })
    .catch(e => {
      console.error(e);
      alert('Por favor inicia sesión nuevamente');
    })
);

export const checkSession = (logged) => ({
  type: IS_LOGGED,
  logged
});

export const validateSession = () => dispatch => (
  axios.get(`${URL}/check_session`)
  .then(response => {
    dispatch(checkSession(response.data.session_initiated));
  })
  .catch(err => {
    console.log(err);
  })
);
