/* eslint-disable import/prefer-default-export */

import { UPDATE_POLL, URL } from '../constants';
import axios from 'axios';

export const updatePoll = (poll) => ({
  type: UPDATE_POLL,
  poll,
});

export const getPoll = (pollId) => {
  return (dispatch) => {
    axios.get(`${URL}/polls/${pollId}.json`)
    .then(response => {
      dispatch(updatePoll(response.data.poll));
    })
    .catch( error => {
      console.log(error);
    });
  }
}
