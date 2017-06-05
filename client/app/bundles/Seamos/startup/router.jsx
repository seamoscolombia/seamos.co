import React from 'react';
import {
    // Redirect,
    HashRouter as Router,
    Route,
    Switch
} from 'react-router-dom';

import Home from '../containers/homeContainer';
import Navbar from '../containers/navbarContainer';
import PollsByTag from '../containers/pollsByTagContainer';
import PollDetail from '../containers/pollDetailContainer';

const AppRouter = () => (
    <Router >
         <div>
            <Navbar />
            <Switch>
                <Route exact path="/" component={Home} />
                <Route exact path="/tag/:tagId/polls" component={PollsByTag} />
                <Route exact path="poll/pollId" component={PollDetail} />
            </Switch>
        </div>
    </Router>
);

export default AppRouter;
