import React from 'react';
import {
    // Redirect,
    HashRouter as Router,
    Redirect,
    Route,
    Switch
} from 'react-router-dom';

import { isAuthenticated } from '../utils';


import Home from '../containers/homeContainer';
import Navbar from '../containers/navbarContainer';
import Profile from '../containers/profileContainer'; 
import Component404 from '../components/component404'; 
import PollsByTag from '../containers/pollsByTagContainer';
import PollDetail from '../containers/pollDetailContainer';
import Tags from '../containers/tagsContainerPage';

const PrivateRoute = ({ component: Component, ...rest }) => (
    <Route 
        {...rest} render={props => (
            isAuthenticated() ? <Component {...props} /> : 
            (<Redirect 
                to={{
                    pathname: '/',
                    state: { from: props.location }
                }}
            />)
        )}  
    />
);

const AppRouter = () => (
    <Router >
         <div>
            <Navbar />
            <Switch>
                <Route exact path="/" component={Home} />
                <Route path="/tags" component={Tags} />
                <Route path="/tag/:tagId/polls" component={PollsByTag} />
                <Route path="/poll/:pollId" component={PollDetail} />
                <PrivateRoute path="/profile" component={Profile} />
                <Route path='/404' component={Component404} />
                <Route component={Component404} />
            </Switch> 
        </div> 
    </Router>
);

export default AppRouter;
