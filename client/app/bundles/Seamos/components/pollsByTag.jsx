import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';

const PollsByTag = (props) => (
  <section id='polls-component'>
    <div className='polls-box'>
      <Polls {...props} />
    </div>
  </section>
);

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
