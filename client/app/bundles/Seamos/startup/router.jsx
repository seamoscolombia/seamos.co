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
import PreHome from '../containers/preHomeContainer';
import Navbar from '../containers/navbarContainer';
import Footer from './../containers/footerContainer';
import Terms from './../containers/termsContainer';
import Politicians from '../containers/politiciansContainer';
import Politician from '../containers/politicianContainer';
import Component404 from '../components/component404';
import Profile from '../containers/profileContainer';
import Polls from '../containers/pollsPageContainer';
import PollsByTag from '../containers/pollsByTagContainer';
import PollDetail from '../containers/pollDetailContainer';
import Tags from '../containers/tagsContainerPage';
import PollsSummaryContainer from '../containers/pollsSummaryContainer';

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

const AppRouter = () => (
  <Router >
    <div>
      <Navbar />
      <Switch>
          <Route exact path="/" component={PreHome} />
          <Route exact path="/_=_" component={PreHome} />
          <Route exact path="/home" component={Home} />
          <Route exact path="/home/_=_" component={Home} />
          <Route path="/tags" component={Tags} />
          <Route path="/tag/:tagId/polls" component={PollsByTag} />
          <Route path="/polls" component={Polls} />
          <Route path="/poll/:pollId" component={PollDetail} />
          <Route path="/terms" component={Terms} />
          <Route path="/politicians" component={Politicians} />
          <Route path="/summary" component={PollsSummaryContainer} />
          <Route path="/proponents/:politicianId" component={Politician} />
          <PrivateRoute path="/profile" component={Profile} />
          <Route path='/404' component={Component404} />
          <Route component={Component404} />
      </Switch>
      <Footer />
    </div>
  </Router>
);

export default AppRouter;
