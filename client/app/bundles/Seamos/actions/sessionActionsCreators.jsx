/* eslint-disable import/prefer-default-export */

import { RESET_SESSION, SET_SESSION } from '../constants';

export const setSession = (authenticityToken) => ({
  type: SET_SESSION,
  authenticityToken
});

export const resetSession = () => ({ type: RESET_SESSION });
