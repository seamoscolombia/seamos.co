import PropTypes from 'prop-types';
import React from 'react';

const Tags = ({ tags }) => (
  <h2>{JSON.stringify(tags)}</h2>
);

Tags.propTypes = {
  tags: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default Tags;
