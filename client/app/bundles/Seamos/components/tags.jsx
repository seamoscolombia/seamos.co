import PropTypes from 'prop-types';
import React from 'react';

const tags = ({ tags }) => (
  <h2>{JSON.stringify(tags)}</h2>
);

tags.propTypes = {
  tags: PropTypes.array.isRequired
  // name: PropTypes.string.isRequired,
  // updateName: PropTypes.func.isRequired,
};

export default tags;
