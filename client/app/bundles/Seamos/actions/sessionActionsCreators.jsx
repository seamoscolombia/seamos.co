/* eslint-disable import/prefer-default-export */
import axios from 'axios';
import { RESET_SESSION, SET_SESSION, URL } from '../constants';

export const setSession = (authenticityToken) => ({
  type: SET_SESSION,
  authenticityToken
});

export const resetUserSession = () => ({ type: RESET_SESSION });

export const resetSession = () => dispatch => (
  axios.delete(`${URL}/sessions.json`)
  .then(() => {
    // debugger
    // window.FB.logout(function(response) {
    //   debugger

    // });
    dispatch(resetUserSession());
  })
  .catch(e => {
    alert('Ha ocurrido un error por favor reporta a nuestro equipo'); //eslint-disable-line
  })
);
