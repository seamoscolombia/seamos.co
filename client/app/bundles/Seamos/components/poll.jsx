import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';

function getDays(remaining) {
  return ((remaining / 3600) / 24);
}
const Poll = (props) => {
  const { id, title, description, poll_image, vote_count, remaining, tag, color } = props;
  let tagColor = 'none';
  if (tag) {
    tagColor = tag.color;
  } else {
    tagColor = color;
  }
  return (
    <div id='poll-component'>
      <div className='poll-image-container'>
      <Link to={`/poll/${id}`} >
        <img alt="poll" src={poll_image} />
      </Link>
      </div>
      <div className='color-separator' style={{ backgroundColor: tagColor }} />
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
          <Link
            to={`/poll/${id}`}
            className='btn button btn-plus-read'
            style={{ backgroundColor: tagColor }}
          >
            LEER +
          </Link>
        </div>
      </div>
    </div>
  );
};

Poll.propTypes = {
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  poll_image: PropTypes.string.isRequired,
  tag: PropTypes.object.isRequired,
  vote_count: PropTypes.number.isRequired,
  remaining: PropTypes.number.isRequired
};

export default Poll;
