import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';

const PollsByTag = (props) => {
  const { tag_image, tag_icon, tag_color, tag_name } = props.tag;
  return (
  <section id='polls-component'>
    <div className='background-container' style={{ backgroundImage: `url(${tag_image})` }}>
      <div className='icon-name-wrapper'>
        <div className='tag-icon-container'>
          <img className='tag-icon' alt='tag icon' src={tag_icon} />
        </div>
        <div className='tag-name'>
          <h1> {tag_name}</h1>
        </div>
      </div>
    </div>
    <div className='polls-box'>
      <Polls {...props} />
    </div>
  </section>
  );
};

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
