import PropTypes from 'prop-types';
import React from 'react';
import Polls from './polls';
import MayInterestContainer from '../containers/mayInterestContainer';

const PollsByTag = (props) => {
const { image, icon, name, color } = props.tag;

  return (
    <div id='polls-component-global-wrapper'>
      <section id='polls-component'>
        <div
          className='background-container'
          style={{ backgroundColor: color }}
        >
          <img src={`${image}`} alt={name} />
          <div className='icon-name-wrapper'>
            <div className='tag-icon-container' style={{ display: 'none' }}>
              <img className='tag-icon' alt='tag icon' src={icon} />
            </div>
            <div className='tag-name'>
              <h1> {name} </h1>
            </div>
          </div>
        </div>
        <div className='polls-box'>
          {props.polls.length !== 0 ?
            <Polls {...props} /> :
            <h3> En el momento no hay propuestas abiertas a votación para este tema </h3>
          }
        </div>
      </section>
      <MayInterestContainer />
    </div>
  );
};

PollsByTag.propTypes = {
  polls: PropTypes.array.isRequired
};

export default PollsByTag;
