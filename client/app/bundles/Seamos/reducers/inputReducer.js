import { UPDATE_INPUT } from '../constants';

const initialState = {};

export default (state = initialState, action) => {
  switch (action.type) {
    case UPDATE_INPUT:
      return { ...state, 
        [action.title]: 
          { ...state[action.title],  
            [action.name]: action.val 
          }
      };
    default:
      return state;
  }
};
