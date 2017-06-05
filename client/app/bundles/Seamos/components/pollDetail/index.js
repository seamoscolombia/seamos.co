import PropTypes from 'prop-types';
import React from 'react';

import SingleButton from './singleButton';
import VotedButton from './votedButton';

const moreInfoStyle = { maxHeight: 150, overflowY: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflowY: 'none' };

function voteButton(pollType, voteTypes, voteAction) {
  switch (pollType) {
    case 'signing': //2
      return (<SingleButton 
        name={voteTypes[0].name}
        onClick={() => { voteAction(voteTypes.id); }}
      />); 
    case 'voting': //0
      return voteTypes.map(voteType => 
        <SingleButton 
          key={`${voteType.name}`}
          name={voteType.name}
          onClick={() => { voteAction(voteType.id); }}
        />
      ); 
    default:
      return null;
  }
}

function votedButton(pollType, voteTypes, vote_count) {
    switch (pollType) {
    case 'signing': //2
      return (<VotedButton 
          count={voteTypes[0].count}
          name={voteTypes[0].name}
          total={vote_count}
      />); 
    case 'voting': //0
      return voteTypes.map(voteType => 
        <VotedButton 
          key={`${voteType.name}`} 
          count={voteType.count}
          name={voteType.name} 
          total={vote_count}
        />
      ); 
    default:
      return null;
  }
}

const PollDetail = ({ 
  id, title, image, remaining,
  description, objective, vote_count,
  user_already_voted, links, politician, 
  poll_type, moreInfo, setMoreInfo, vote_types,
  voteAction
}) => (
  <section id='poll-detail'>
    <header>{ title }</header> 
    <section id='politician'>
      <img src={politician.picture} role='presentation' alt='politician' />
      <div className='author'>por {politician.full_name}</div>
    </section> 
    <section id='poll-section'>
      <div className='poll-section-containers' >
        <img id='poll-thumbnail' src={image} role='presentation' alt='poll thumbnail' />
        <br />
         <small>Objetivo: {objective}</small>
      </div>
      <div className='poll-section-containers' >
        <p style={moreInfo ? lessInfoStyle : moreInfoStyle}>
          { description }  
        </p>
        <br />
        <button onClick={setMoreInfo} id='plus-info'>
          { moreInfo ? '-INFO' : '+INFO' }
        </button>
        <br /><br />
        { user_already_voted ?
          votedButton(poll_type, vote_types, vote_count) :
          voteButton(poll_type, vote_types, voteAction) 
        }
      </div>
    </section> 
  </section>
);

PollDetail.propTypes = {
  id: PropTypes.number.isRequired,
  title: PropTypes.string.isRequired,
  image: PropTypes.string.isRequired,
  description: PropTypes.string.isRequired,
  objective: PropTypes.string.isRequired,
  remaining: PropTypes.number.isRequired,
  vote_count: PropTypes.number.isRequired,
  poll_type: PropTypes.string.isRequired,
  user_already_voted: PropTypes.bool.isRequired,
  links: PropTypes.array.isRequired,
  politician: PropTypes.object.isRequired,
  moreInfo: PropTypes.bool,
  vote_types: PropTypes.array,
  voteAction: PropTypes.func.isRequired
};

export default PollDetail;
