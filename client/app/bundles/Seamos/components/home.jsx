import React from 'react';
import { Link } from 'react-router-dom';
import FacebookLogin from '../containers/facebookLoginContainer';
import Tags from '../containers/tagsContainer';
import PollsPageContainer from '../containers/pollsPageContainer'

import Polls from '../containers/pollsFeatureContainer';
import Featured from '../containers/pollsPageContainer';
import InputContainer from '../containers/inputContainer';


const Home = ({ session, inputReducer, subscribeNewsletter, newsletterReducer }) => (
  <div id="homepage">
    <div className='background-container top'>
    </div>
    <div className="mid-container">
      <div className="left-col">
        <div className="title">
          <h1>Temas de Interés</h1>
        </div>
        <Tags />
      </div>
      <div className="right-col">
        <PollsPageContainer />
      </div>
    </div>
  </div>
);

Home.propTypes = {
  // Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
