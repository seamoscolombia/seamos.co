import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';

const PollsByTag = (props) => (
  <section>
    <Polls {...props} />
  </section>
);

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
