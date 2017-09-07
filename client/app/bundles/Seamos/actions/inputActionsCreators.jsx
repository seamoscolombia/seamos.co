import axios from 'axios';

import { UPDATE_INPUT, URL } from '../constants';

export const updateInput = (title, name, val) => ({
  type: UPDATE_INPUT,
  title,
  name,
  val
});

export const subscribeNewsletter = email => dispatch => {
  const subscription = {
    email
  };
  return axios.post(`${URL}/subscriptions`, {
    subscription
  })
  .then(response => {
    console.log(response);
  })
  .catch(err => {
    console.log(err);
  });
};
