/* eslint-disable import/prefer-default-export */
import axios from 'axios';
import { RESET_SESSION, SET_SESSION, URL } from '../constants';

export const setSession = (authenticityToken) => ({
  type: SET_SESSION,
  authenticityToken
});

export const resetUserSession = () => ({ type: RESET_SESSION });

export const resetSession = () => dispatch => (
  axios.delete(`${URL}/destroy_facebook_session.json`)
  .then(() => dispatch(resetUserSession()))
  .catch(e => {
    alert('Por favor inicia sesión nuevamente'); //eslint-disable-line
  })
);
