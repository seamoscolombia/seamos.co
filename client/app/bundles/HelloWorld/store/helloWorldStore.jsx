import { createStore } from 'redux';
import helloWorldReducer from '../reducers';

const configureStore = (railsProps) => (
  createStore(helloWorldReducer, railsProps)
);

export default configureStore;
