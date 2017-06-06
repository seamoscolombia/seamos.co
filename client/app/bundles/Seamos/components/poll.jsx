import PropTypes from 'prop-types';
import React from 'react';

function getDays(remaining) {
  return ((remaining / 3600) / 24);
}
const Poll = ({ title, description, poll_image, vote_count, remaining, tag }) => {
  const { tag_image, tag_icon, tag_color, tag_name } = tag;
  return (
    <div id='poll-component'>
      <div className='poll-image-container'>
        <img alt="poll" src={poll_image} />
      </div>
      <div className='color-separator' style={{ backgroundColor: tag_color }} />
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
          {vote_count} participaciones <span> | quedan {getDays(remaining)} días</span>
        </div>
      </div>
    </div>
  );
}

Poll.propTypes = {
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  poll_image: PropTypes.string.isRequired,
  tag: PropTypes.tag.isRequired,
  vote_count: PropTypes.number.isRequired,
  remaining: PropTypes.number.isRequired
};

export default Poll;
