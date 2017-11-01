import PropTypes from 'prop-types';
import React from 'react';
import Poll from './poll';
import OtherProfilePoll from './otherProfilePoll';


const Polls = ({ polls, tag, type }) => (
  <div className='polls-wrapper'>
    { polls.length === 0 && window.location.hash.split('/')[1] === '' ?
      <h3 className='reminder'> Regístrate y selecciona los temas de tu interés en tu perfil. </h3> :
      polls.map(
          poll => (
              <div>
                {type === 'horizontal' ?
                  <OtherProfilePoll {...poll} key={poll.id} tag={tag} />
                  :
                  <Poll {...poll} key={poll.id} tag={tag} />
                }
              </div>
                  )
               )
    }
  </div>
);

Polls.propTypes = {
  polls: PropTypes.array.isRequired
};

export default Polls;
