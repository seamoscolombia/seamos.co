import React, {Component} from 'react';
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
import Footer from './../containers/footerContainer';
import Terms from './../containers/termsContainer';
import Team from './../containers/teamContainer';
import Politician from '../containers/politicianContainer';
import Component404 from '../components/component404';
import Profile from '../containers/profileContainer';
import PollsClosed from '../containers/pollsClosedContainer';
import Polls from '../containers/pollsPageContainer';
import PollsByTag from '../containers/pollsByTagContainer';
import PollDetail from '../containers/pollDetailContainer';
import Tags from '../containers/tagsContainerPage';
import Loader from '../containers/loaderContainer';

const PrivateRoute = ({ component: Component, ...rest }) => (
    <Route
        {...rest} render={props => (
            isAuthenticated() ? <Component {...props} /> :
            (<Redirect
                to={{
                    pathname: '/404',
                    state: { from: props.location }
                }}
            />)
        )}
    />
);

class AppRouter extends Component {
    constructor(props) {
        super(props);

        this.state = {
        isLoading: true
        };
    }

    componentDidMount() {
        setTimeout(() => this.setState({ isLoading: false }), 1500);
    }

    render() {
        return (
            <Router >
                <div>
                    { this.state.isLoading ?
                        <div className="loader-container">
                            <Loader />
                        </div>
                        : null
                    }
                    <Navbar />
                    <Switch>
                        <Route exact path="/" component={Home} />
                        <Route exact path="/_=_" component={Home} />
                        <Route path="/tags" component={Tags} />
                        <Route path="/tag/:tagId/polls" component={PollsByTag} />
                        <Route path="/polls" component={Polls} />
                        <Route path="/poll/:pollId" component={PollDetail} />
                        <Route path="/closed-polls" component={PollsClosed} />
                        <Route path="/terms" component={Terms} />
                        <Route path="/team" component={Team} />
                        <Route path="/proponents/:politicianId" component={Politician} />
                        <PrivateRoute path="/profile" component={Profile} />
                        <Route path='/404' component={Component404} />
                        <Route component={Component404} />
                    </Switch>
                    <Footer />
                </div>
            </Router>
        );
    }
}

export default AppRouter;
