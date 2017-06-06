import PropTypes from 'prop-types';
import React from 'react';

const Poll = ({ title, description, poll_image, vote_count, remaining }) => (
  <div id='poll-component'>
    <div className='poll-image-container'>
      <img alt="poll" src={poll_image} />
    </div>
    <div className='color-separator' style={{"backgroundColor": "#333"}} />
    <div className='poll-infos-container'>
      <div className='poll-info'>
        <div className='poll-title'>
          {title}
        </div>
        <div className='poll-description'>
          {description}
        </div>
      </div>
      <div className='poll-details'>
        {vote_count} participaciones  <span> | quedan {remaining / 3600 / 24} días</span>
      </div>
    </div>
  </div>

);

Poll.propTypes = {
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  poll_image: PropTypes.string.isRequired,
  vote_count: PropTypes.number.isRequired,
  remaining: PropTypes.number.isRequired
};

export default Poll;
