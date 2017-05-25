/* eslint-disable import/prefer-default-export */

import { UPDATE_TAGS, URL } from '../constants';
import axios from 'axios';

export const updateTags = (tags) => ({
  type: UPDATE_TAGS,
  tags,
});

export const getTags = () => {
  return (dispatch) => {
    axios.get(`${URL}/tags.json`)
    .then(response => {
      dispatch(updateTags(response.data.tags));
    })
    .catch( error => {
      console.log(error);
    });
  }
}