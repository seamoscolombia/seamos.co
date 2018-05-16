import axios from 'axios';

import { UPDATE_INPUT, URL, SUBSCRIBE_TO_NEWSLETTER } from '../constants';

export const updateInput = (title, name, val) => ({
  type: UPDATE_INPUT,
  title,
  name,
  val
});

export const subscribeToNewsletter = (valid, message) => ({
  type: SUBSCRIBE_TO_NEWSLETTER,
  valid,
  message
});

export const subscribeNewsletter = email => dispatch => {
  const re = /([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/gi;
  if (!re.test(email)) {
    return dispatch(subscribeToNewsletter(false, `Lo sentimos, ${email} no es un correo valido`));
  }
  const subscription = {
    email
  };
  return axios.post(`${URL}/subscriptions`, {
    subscription
  })
  .then(response => {
    return dispatch(subscribeToNewsletter(response.data.success, response.data.message));
  })
  .catch(err => {
    console.log(err);
  });
};
