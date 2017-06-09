import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';

const PollsByTag = (props) => {
  const { image, icon, color, name } = props.tag;
  return (
    <section id='polls-component'>
      <div className='background-container' style={{ backgroundImage: `url(${image})` }}>
        <div className='icon-name-wrapper'>
          <div className='tag-icon-container'>
            <img className='tag-icon' alt='tag icon' src={icon} />
          </div>
          <div className='tag-name'>
            <h1> {name}</h1>
          </div>
        </div>
      </div>
      <div className='polls-box'>
        { props.polls.length !== 0 ?
          <Polls {...props} /> :
          <h3> Por el momento no hay propuestas para este tema </h3>
        }
      </div>
    </section>
  );
};

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
