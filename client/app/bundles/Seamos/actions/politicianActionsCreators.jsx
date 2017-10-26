/* eslint-disable import/prefer-default-export */
/* eslint-disable window.localStorage */

import axios from 'axios';
import { SET_POLITICIAN, URL } from '../constants';

export const setPolitician = (politician) => ({
  type: SET_POLITICIAN,
  politician,
});

export const getPolitician = (id) => (dispatch) => (
  axios.get(`${URL}/proponents/${id}.json`)
    .then(response => {
      dispatch(setPolitician(response.data.user));
    })
    .catch(e => {
      alert('Por favor inicia sesión nuevamente');
    })
);
