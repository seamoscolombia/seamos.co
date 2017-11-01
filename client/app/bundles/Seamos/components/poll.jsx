import PropTypes from 'prop-types';
import React from 'react';
import { Link } from 'react-router-dom';

function myVote(vote) {
  return (
    <div className='poll-my-vote'>
      <span className='poll-vote-title'>Mi voto: </span><span>{vote}</span>
    </div>
  )
}

const Poll = (props) => {
  const { id, title, is_closed, summary, poll_image, tag, color, tag_name, politician, user_vote } = props;
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
    <a href={`/client/polls/${id}`} style={{ textDecoration: 'none' }}>
      <div id='poll-component'>
        { user_vote ? myVote(user_vote) : null }
        <div className='poll-image-container'>
            <img alt="poll" src={poll_image} />
        </div>
        <div className='closed-ribbon' style={{ display: `${is_closed ? 'auto' : 'none'}` }}>
          Propuesta Cerrada
        </div>
        <div className='poll-title'>
          <span>
            {title}
          </span>
        </div>
        <div className='poll-description'>
          {summary}
        </div>
        <div className='politician-info'>
          <div className='picture-container'>
            <img src={politician.picture} alt='politician' />
          </div>
          <div className='name-container'>
            {politician.full_name}
          </div>
        </div>
        <div className='poll-infos-container'>
          <div className='poll-details'>
            <div className='poll-tag-name'>
              {tagName}
            </div>
            <div className='color-separator' style={{ borderLeft: `5px solid ${tagColor}` }} />
            <div
              className='btn button btn-plus-read'
              style={{ backgroundColor: tagColor }}
            >
              {is_closed ? 'RESULTADOS' : 'VOTA'}
            </div>
          </div>
        </div>
      </div>
    </a>
  );
};

Poll.propTypes = {
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  poll_image: PropTypes.string.isRequired,
  tag: PropTypes.object.isRequired,
  vote_count: PropTypes.number.isRequired
};

export default Poll;
