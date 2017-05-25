/* eslint-disable import/prefer-default-export */

import { UPDATE_POLLS, URL } from '../constants';
import axios from 'axios';

export const updatePolls = (polls) => ({
  type: UPDATE_POLLS,
  polls,
});

export const getPolls = () => {
  return (dispatch) => {
    axios.get(`${URL}/polls.json`)
    .then(response => {
      dispatch(updatePolls(response.data.polls));
    })
    .catch( error => {
      console.log(error);
    });
  }
}