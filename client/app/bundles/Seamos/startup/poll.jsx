import React from 'react';

import RailsNavbarContainer from '../containers/railsNavbarContainer';
import PollDetailContainer from '../containers/pollDetailContainer';
import RailsFooterContainer from '../containers/railsFooterContainer';

const Poll = () => (
  <div>
    <RailsNavbarContainer />
    <PollDetailContainer />
    <RailsFooterContainer />
  </div>
);

export default Poll;
