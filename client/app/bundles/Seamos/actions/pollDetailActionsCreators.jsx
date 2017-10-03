/* eslint-disable import/prefer-default-export */

import axios from 'axios';
import { history } from 'react-router-dom';
import { UPDATE_POLL, URL } from '../constants';

export const updatePoll = (poll) => ({
  type: UPDATE_POLL,
  poll,
});

export const getPoll = ({ pollId, errCallback }) => (dispatch) => {
    console.log(URL, pollId);
    axios.get(`${URL}/polls/${pollId}.json`)
    .then(response => {
      console.log('RESPONSE', response);
      dispatch(updatePoll(response.data.poll));
    })
    .catch(error => {
      console.log('ERROR', error);
    });
};

export const votePoll = ({ voteTypeId, authenticityToken, poll }) => (dispatch) => (
  axios.post(`${URL}/votes.json`, {
    vote: { vote_type_id: voteTypeId },
    authenticity_token: authenticityToken
  })
  .then(() => {
    poll.user_already_voted = true;
    poll.vote_types.map((vote) => {
      return (vote.id === voteTypeId) ? vote.count += 1 : vote.count;
      }
    );
    poll.vote_count += 1
    dispatch(updatePoll(poll));
  })
  .catch(error => {
    console.log(error);
  })
);

export const chechVotedPol = (userId, poll) => (dispatch) => {
  axios.get(`${URL}/check_vote?user_id=${userId}&poll_id=${poll.id}`)
  .then(response => {
    poll.user_already_voted = response.data.already_voted;
    poll.prevent_loop = false;
    dispatch(updatePoll(poll));
  })
  .catch(error => {
    console.error(error);
  });
};
