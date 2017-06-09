import { UPDATE_INTERESTS } from '../constants';

export default (state = false, action) => {
  switch (action.type) {
    case UPDATE_INTERESTS: {
      const newState = !state;
      return newState;
    } default:
      return state;
  }
};
