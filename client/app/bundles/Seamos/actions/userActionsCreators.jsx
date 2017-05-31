/* eslint-disable import/prefer-default-export */
/* eslint-disable localStorage */

import axios from 'axios';
import { SET_USER, URL } from '../constants';

export const createUser = (fbUser) => dispatch => {
  const user = {
    names: fbUser.first_name,
    first_surname: fbUser.last_name,
    second_surname: 'N.A.',
    email: fbUser.email
  };
  axios.post(`${URL}/usuarios.json`, {
    authenticity_token: localStorage.getItem('authenticityToken'), //eslint-disable-line
    user
  })
  .then(response => {
    dispatch(setUser(response.data.user));
  })
  .catch(e => {
    alert('Ah ocurrido un error por favor reporta a nuestro equipo');
  });
};

export const getUser = () => (dispatch) => {
  axios.get(`${URL}/profile.json`)
    .then(response => {
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

export const validateUserSession = (fbUser) => (dispatch) => {
  axios.post(`${URL}/sessions.json`, {
    uid: fbUser.id,
    fb_token: fbUser.accessToken
  })
    .then(response => {
      const authenticityToken = response.data.authenticity_token;
      localStorage.setItem('authenticityToken', authenticityToken); //eslint-disable-line 
      // localStorage.setItem('image', fbUser.picture.data.url); //eslint-disable-line
      dispatch(getUser());
    })
    .catch(e => {
      if (e.response && e.response.status === 422) {
        //console.log(‘Error to Register’);
        e.response.json()
          .then(responseJson => {
            //console.log(responseJson.authenticity_token);
            localStorage.setItem('authenticityToken', responseJson.authenticity_token); //eslint-disable-line
            dispatch(createUser(fbUser));
          });
      } else {
        console.warn('Error != 422');
        if (!e.response) {
          throw e;
        }
        alert('Ah ocurrido un error por favor reporta a nuestro equipo');
      }
    });
};
