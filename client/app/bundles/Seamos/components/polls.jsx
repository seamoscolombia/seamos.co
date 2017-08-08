import PropTypes from 'prop-types';
import React from 'react';
import Poll from './poll';


const Polls = ({ polls, tag }) => (
  <div className='polls-wrapper'>
    { polls.length !== 0 ? polls.map(poll => (
        <Poll {...poll} key={poll.id} tag={tag} />
      )) :
      <h3> En el momento no tenemos propuestas abiertas a votación
      en tus temas de interés, recuerda seleccionarlos en tu perfil. </h3>
    }
  </div>
);

Polls.propTypes = {
  polls: PropTypes.array.isRequired
};

export default Polls;
