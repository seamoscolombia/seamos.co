import PropTypes from 'prop-types';
import React from 'react';
import Poll from './poll';


const Polls = ({ polls, tag }) => (
  <div className=''>
    { polls.map(poll => (
        <Poll {...poll} key={poll.id} tag={tag} />
      ))
    }
  </div>
);

Polls.propTypes = {
  polls: PropTypes.array.isRequired
};

export default Polls;
