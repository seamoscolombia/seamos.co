/* eslint-disable import/prefer-default-export */

export const GET_POLLS = 'GET_POLLS';
export const GET_TAGS = 'GET_TAGS';
export const RESULT_POLLS = 'result_polls';
export const SET_POLL = 'set_poll';
export const SET_VOTED_POLL = 'set_voted_poll';
export const SET_VOTE_RESULTS = 'set_vote_results';
export const SET_VOTE_DEBATE_RESULTS = 'set_vote_debate_results';
export const UPDATE_INTERESTS = 'UPDATE_INTERESTS';
export const UPDATE_POLL = 'update_poll';
export const UPDATE_POLLS = 'UPDATE_POLLS';
export const UPDATE_TAG = 'UPDATE_TAG';
export const UPDATE_TAGS = 'UPDATE_TAGS';
export const ADD_TAGS_ON_USER = 'ADD_TAGS_ON_USER';
export const DELETE_TAGS_ON_USER = 'DELETE_TAGS_ON_USER';
export const SET_POLITICIAN = 'SET_POLITICIAN';
export const PRODUCTION_URL = 'https://seamos.herokuapp.com';
// export const PRODUCTION_URL = 'https://seamosproduction.mybluemix.net';
export const URL = (process.env.NODE_ENV === 'development') ? 'http://localhost:3000' : PRODUCTION_URL;
export const APP_ID = (process.env.NODE_ENV === 'development') ? '1541054365966079' : '1707774202581080';
export const SET_USER = 'SET_USER';
export const SET_SESSION = 'SET_SESSION';
export const RESET_SESSION = 'RESET_SESSION';
export const VALIDATE_ACTUAL_POLL = 'validate_actual_poll';
export const VOTED_POLLS = 'voted_polls';
export const LOGGED_MESSAGE = 'Sesión iniciada';
export const IS_LOGGED = 'IS_LOGGED';
export const TOASTER_DISPLAY = 'TOASTER_DISPLAY';
