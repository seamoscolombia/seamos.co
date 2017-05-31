import React from 'react';
import {
    // Redirect,
    HashRouter as Router,
    Route,
    Switch
} from 'react-router-dom';

// import Home from '../containers/homeContainer';
import Polls from '../containers/pollsContainer';

const AppRouter = () => (
    <Router >
        <Switch>
            <Route exact path="/" component={Polls} />
        </Switch>
    </Router>
);

export default AppRouter;
