/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { UPDATE_TAGS, URL } from '../constants';

export const updateTags = (tags) => ({
  type: UPDATE_TAGS,
  tags,
});

export const getTags = () => (dispatch) => {
    axios.get(`${URL}/tags.json`)
    .then(response => {
      dispatch(updateTags(response.data.tags));
    })
    .catch(error => {
      console.log(error);
    });
};
