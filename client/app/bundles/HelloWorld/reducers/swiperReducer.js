import { SWIPED_POLL } from '../constants';

export default (state = true, action) => {
  switch (action.type) {
    case SWIPED_POLL:
      return !action.swiped;
    default:
      return state;
  }
};
