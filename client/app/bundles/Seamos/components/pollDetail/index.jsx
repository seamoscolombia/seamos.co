import PropTypes from 'prop-types';
import React from 'react';
import SingleButton from './singleButton';

const moreInfoStyle = { maxHeight: 150, overflowY: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflowY: 'none' };

function getPollType(pollType, voteTypes) {
  switch (pollType) {
    case 'signing': //2
      return <SingleButton name={voteTypes[0].name} />; 
    case 'voting': //0
      return voteTypes.map(voteType => 
        <SingleButton key={`${voteType.name}`} name={voteType.name} />
      ); 
    case 'participation': //1
      return null; 
    default:
      return null;
  }
}
const PollDetail = ({ 
  id, title, image,
  description, objective, remainingTime,
  vote_count, user_already_voted, links,
  politician, poll_type, moreInfo, setMoreInfo, vote_types
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
        { getPollType(poll_type, vote_types) }
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
  remainingTime: PropTypes.number.isRequired,
  vote_count: PropTypes.number.isRequired,
  poll_type: PropTypes.number.isRequired,
  user_already_voted: PropTypes.bool.isRequired,
  links: PropTypes.array.isRequired,
  politician: PropTypes.object.isRequired,
  moreInfo: PropTypes.bool.isrequired,
  vote_types: PropTypes.array.isrequired,
};

export default PollDetail;
