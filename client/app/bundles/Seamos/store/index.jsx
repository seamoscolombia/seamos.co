import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import Reducers from '../reducers';

const configureStore = (railsProps) => (
  createStore(Reducers, railsProps, applyMiddleware(thunk))
);

export default configureStore;
