/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { UPDATE_POLL, URL } from '../constants';

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
  };
};

export const votePoll = ({ voteTypeId, authenticityToken, poll }) => (dispatch) => (
  axios.post(`${URL}/votes.json`, { 
    vote: { vote_type_id: voteTypeId }, 
    authenticity_token: authenticityToken 
  })
  .then(() => {
    debugger
    poll.user_already_voted = true;
    dispatch(updatePoll(poll));
  })
  .catch(error => {
    console.log(error);
  })
);