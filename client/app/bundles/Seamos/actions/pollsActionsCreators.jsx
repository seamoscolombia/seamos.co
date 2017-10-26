/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { updateTag } from './tagActionsCreators';
import { UPDATE_POLLS, URL, MAY_INTEREST } from '../constants';

export const updatePolls = (polls) => ({
  type: UPDATE_POLLS,
  polls,
});

export const getPolls = (val = 'most-voted-first') => (dispatch) => (
    axios.get(`${URL}/polls.json?order_by=${val}`)
    .then(response => {
      dispatch(updatePolls(response.data.polls));
    })
    .catch(error => {
      console.log(error);
    })
);

export const getClosedPolls = () => (dispatch) => (
    axios.get(`${URL}/polls/closed`)
    .then(response => {
      dispatch(updatePolls(response.data.polls));
    })
    .catch(error => {
      console.log(error);
    })
);

export const pollsFilteredByTag = (tagId) => (dispatch) => {
  if (tagId) {
    return axios.get(`${URL}/tags/${tagId}/polls.json`)
    .then(response => {
      dispatch(updateTag(response.data.filtered_by_tag.tag));
      dispatch(updatePolls(response.data.filtered_by_tag.polls));
    })
    .catch(error => {
      console.log(error);
    });
  }
};

const mayInteresPolls = (polls) => ({
  type: MAY_INTEREST,
  polls
});

export const getMayInterestPolls = () => (dispatch) => {
  axios.get(`${URL}/random_polls`)
  .then(response => {
    dispatch(mayInteresPolls(response.data.polls));
  })
  .catch(err => {
    console.log(err);
  });
};
