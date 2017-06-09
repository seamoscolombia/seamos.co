/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { updateTag } from './tagActionsCreators';
import { UPDATE_POLLS, URL } from '../constants';

export const updatePolls = (polls) => ({
  type: UPDATE_POLLS,
  polls,
});

export const getPolls = () => (dispatch) => (
    axios.get(`${URL}/polls.json`)
    .then(response => {
      dispatch(updatePolls(response.data.polls));
    })
    .catch(error => {
      console.log(error);
    })
);

export const pollsFilteredByTag = (tagId) => (dispatch) => (
  axios.get(`${URL}/tags/${tagId}/polls.json`)
  .then(response => {
    dispatch(updateTag(response.data.filtered_by_tag.tag));
    dispatch(updatePolls(response.data.filtered_by_tag.polls));
  })
  .catch(error => {
    console.log(error);
  })
);
