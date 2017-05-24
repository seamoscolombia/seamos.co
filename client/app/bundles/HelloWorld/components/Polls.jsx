import PropTypes from 'prop-types';
import React from 'react';

const Polls = (polls) => (
  <h2>{JSON.stringify(polls)}</h2>
);

Polls.propTypes = {
  polls: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Polls;
