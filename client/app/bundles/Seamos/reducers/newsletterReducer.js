import { SUBSCRIBE_TO_NEWSLETTER } from '../constants';

const initialState = {
  message: null,
  valid: null
};

export default (state = initialState, action) => {
  switch (action.type) {
    case SUBSCRIBE_TO_NEWSLETTER:
      return { ...state, 
        valid: action.valid,
        message: action.message
      };
    default:
      return state;
  }
};
