import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';

const Poll = (props) => {
  const { id, title, description, summary, poll_image, tag, color, tag_name, politician } = props;
  let tagColor = 'none';
  if (tag) {
    tagColor = tag.color;
  } else {
    tagColor = color;
  }
  let tagName = 'none';
  if (tag) {
    tagName = tag.name;
  } else {
    tagName = tag_name;
  }
  return (
    <Link to={`/poll/${id}`} style={{ textDecoration: 'none' }}>
      <div id='poll-component'>
        <div className='poll-title'>
          <span>
            {title}
          </span>
        </div>
        <div className='politician-info'>
          <div className='picture-container'>
            <img src={politician.picture} alt='politician' />
          </div>
          <div className='name-container'>
            {politician.full_name}
          </div>
        </div>
        <div className='poll-image-container'>

            <img alt="poll" src={poll_image} />

        </div>
        <div className='poll-infos-container'>
          <Link to={`/poll/${id}`} className='poll-info'>
              <div className='poll-description'>
                {summary}
              </div>
          </Link>
          <div className='poll-details'>
            <div className='poll-tag-name'>
              {tagName}
            </div>
            <div
              className='color-separator'
              style={{ borderLeft: `5px solid ${tagColor}` }}
            />
            <Link
              to={`/poll/${id}`}
              className='btn button btn-plus-read'
              style={{ backgroundColor: tagColor }}
            >
              VOTA
            </Link>
          </div>
        </div>
      </div>
    </Link>
  );
};

Poll.propTypes = {
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  poll_image: PropTypes.string.isRequired,
  tag: PropTypes.object.isRequired,
  vote_count: PropTypes.number.isRequired
};

export default Poll;
