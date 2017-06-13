/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { history } from 'react-router-dom';
import { UPDATE_POLL, URL } from '../constants';

export const updatePoll = (poll) => ({
  type: UPDATE_POLL,
  poll,
});

export const getPoll = ({ pollId, errCallback }) => (dispatch) => {
    axios.get(`${URL}/polls/${pollId}.json`)
    .then(response => {
      dispatch(updatePoll(response.data.poll));
    })
    .catch( error => {
      if (error.response.status === 404) {
        errCallback();
      } else {
        console.error(error);
      }
    });
};

export const votePoll = ({ voteTypeId, authenticityToken, poll }) => (dispatch) => (
  axios.post(`${URL}/votes.json`, { 
    vote: { vote_type_id: voteTypeId }, 
    authenticity_token: authenticityToken 
  })
  .then(() => {
    poll.user_already_voted = true;
    poll.vote_types.find((vote) => {vote.id == voteTypeId; return vote.count += 1} );
    dispatch(updatePoll(poll));
  })
  .catch(error => {
    console.log(error);
  })
);