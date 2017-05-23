import { INDEX_DEBATES } from '../constants';

export default (state = null, action) => {
  switch (action.type) {
    case INDEX_DEBATES:
      return action.debates;
    default:
      return state;
  }
};
