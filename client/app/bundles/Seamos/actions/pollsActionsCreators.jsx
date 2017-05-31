/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { UPDATE_POLLS, URL } from '../constants';

export const updatePolls = (polls) => ({
  type: UPDATE_POLLS,
  polls,
});

export const getPolls = () => (dispatch) => {
    axios.get(`${URL}/polls.json`)
    .then(response => {
      dispatch(updatePolls(response.data.polls));
    })
    .catch(error => {
      console.log(error);
    });
  };
