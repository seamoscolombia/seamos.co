import React from 'react'; 
import {
    // Redirect,
    HashRouter as Router,
    Route,
    Switch
} from 'react-router-dom';

import Home from '../containers/homeContainer';
import Navbar from '../containers/navbarContainer'; 
import PollsByTag from '../component/pollsByTag'; 

const AppRouter = () => (
    <Router >
         <div> 
            <Navbar /> 
            <Switch> 
                <Route exact path="/" component={Home} />
                <Route exact path="tag/:tagId/polls" component={Home} />
            </Switch> 
        </div> 
    </Router>
);

export default AppRouter;

