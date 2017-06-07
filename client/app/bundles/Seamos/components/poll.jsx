import PropTypes from 'prop-types';
import React from 'react';

function getDays(remaining) {
  return ((remaining / 3600) / 24);
}
const Poll = (props) => {
  const { title, description, poll_image, vote_count, remaining, tag } = props;
  let tag_color = 'none';
  if (tag) {  tag_color = tag.tag_color; }
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
          <span> {vote_count} participaciones </span>
          <span className='separator'> | </span>
          <span> quedan {getDays(remaining)} días</span>
          <span className='separator'> | </span>
          <a href='#' className='btn button btn-plus-read' style={{ backgroundColor: tag_color }}>
            LEER +
           </a>
        </div>
      </div>
    </div>
  );
};

Poll.propTypes = {
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  poll_image: PropTypes.string.isRequired,
  tag: PropTypes.object.isRequired,
  vote_count: PropTypes.number.isRequired,
  remaining: PropTypes.number.isRequired
};

export default Poll;
