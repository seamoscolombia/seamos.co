/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { updateInterestsShow } from './interestsActionsCreators';
import { UPDATE_TAGS, URL } from '../constants';

export const updateTags = (tags) => ({
  type: UPDATE_TAGS,
  tags,
});

export const getTags = () => (dispatch) => (
    axios.get(`${URL}/tags.json`)
    .then(response => {
      const tags = response.data.tags;
      const filtered = tags.filter(tag => tag.polls_count > 0);
      dispatch(updateTags(filtered));
    })
    .catch(error => {
      console.log(error);
    })
);

export const getInterests = (userId) => (dispatch) => (
    axios.get(`${URL}/users/${userId}/tags.json`)
    .then(response => {
      dispatch(updateTags(response.data.interests));
    })
    .catch(error => {
      console.log(error);
    })
);
