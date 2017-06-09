/* eslint-disable import/prefer-default-export */

import { UPDATE_TAG } from '../constants';

export const updateTag = (tag) => ({
  type: UPDATE_TAG,
  tag,
});
