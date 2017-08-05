/* eslint-disable import/prefer-default-export */

import { SHOW_SPINNER, HIDE_SPINNER } from '../constants';

export const showSpinner = (spinner) => ({
  type: SHOW_SPINNER,
  spinner,
});

export const hideSpinner = (spinner) => ({
  type: HIDE_SPINNER,
  spinner,
});
