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
import PollDetail from '../containers/pollDetailContainer'; 
import Component404 from '../components/component404'; 

const AppRouter = () => (
    <Router >
         <div>
            <Navbar />
            <Switch>
                <Route exact path="/" component={Home} />
                <Route path="/tag/:tagId/polls" component={PollsByTag} />
                <Route path="/poll/:pollId" component={PollDetail} />
                <Route path='/404' component={Component404} />
                <Route component={Component404} />
            </Switch> 
        </div> 
    </Router>
);

export default AppRouter;
