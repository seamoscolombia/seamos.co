import React, {Component} from 'react';
import { Provider } from 'react-redux';

import AppRouter from './router';
import configureStore from '../store';

// See documentation for https://github.com/reactjs/react-redux.
// This is how you get props from the Rails view into the redux store.
// This code here binds your smart component to the redux store.
// railsContext provides contextual information especially useful for server rendering, such as
// knowing the locale. See the React on Rails documentation for more info on the railsContext
const SeamosApp = (props) => (
  <Provider store={configureStore(props)}>
    <AppRouter />
  </Provider>
);

export default SeamosApp;
