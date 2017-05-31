import { SET_USER } from '../constants';


// const INITIAL_STATE = [{ //use for reference
//   id: null,
//   title: null,
//   description: null,
//   closing_date: null,
//   poll_image: 'null',
//   vote_types: [{ id: null, name: 'null' }]
// }];
const INITIAL_STATE = localStorage.getItem('user') ? //eslint-disable-line
  JSON.parse(localStorage.getItem('user')) //eslint-disable-line
  : { }; 
  
export default (state = INITIAL_STATE, action) => {
  switch (action.type) {
    case SET_USER: {
      const user = Object.assign({}, state, action.user);
      localStorage.setItem('user', user); //eslint-disable-line
      debugger
      return user;
    }
    default:
      return state;
  }
};
