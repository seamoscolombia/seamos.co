import PropTypes from 'prop-types';
import React from 'react';

const Poll = ({ title, description }) => (
  <div>
    <h1> {title} </h1>
    <p> {description} </p>
  </div>

);

Poll.propTypes = {
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
};

export default Poll;
