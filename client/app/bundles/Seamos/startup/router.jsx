import React from 'react'; 
import {
    // Redirect,
    HashRouter as Router,
    Route,
    Switch
} from 'react-router-dom';

import Home from '../containers/homeContainer';
import Navbar from '../containers/navbarContainer'; 

const AppRouter = () => (
    <Router >
         <div> 
            <Navbar /> 
            <Switch> 
                <Route exact path="/" component={Home} />
            </Switch> 
        </div> 
    </Router>
);

export default AppRouter;

