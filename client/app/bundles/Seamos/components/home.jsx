import PropTypes from 'prop-types';
import React from 'react';

const Home = (props) => (
  <h1 className='abc'>Home</h1>
);

Home.propTypes = {
  Home: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Home;
