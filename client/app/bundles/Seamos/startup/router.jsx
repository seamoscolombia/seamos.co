import React from 'react';
import {
    // Redirect,
    HashRouter as Router,
    Route,
    Switch
} from 'react-router-dom';

// import Home from '../containers/homeContainer';
import Polls from '../containers/pollsContainer';
import Navbar from '../components/navbar';

const AppRouter = () => (
    <Router >
        <div>
            <Navbar />
            <Switch>
                <Route exact path="/" component={Polls} />
            </Switch>
        </div>
    </Router>
);

export default AppRouter;
