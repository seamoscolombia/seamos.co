import React from 'react';
import {
    // Redirect,
    HashRouter as Router,
    Route,
    Switch
} from 'react-router-dom';

import Home from '../containers/homeContainer';
import Navbar from '../containers/navbarContainer';
import PollsByTag from '../components/pollsByTag';

const AppRouter = () => (
    <Router >
         <div>
            <Navbar />
            <Switch>
                <Route exact path="/" component={Home} />
                <Route exact path="tag/:tagId/polls" component={PollsByTag} />
            </Switch>
        </div>
    </Router>
);

export default AppRouter;
