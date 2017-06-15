import PropTypes from 'prop-types';
import React from 'react';

import CountDown from '../../containers/countdownContainer';
import SingleButton from './singleButton';
import VotedButton from './votedButton';

const moreInfoStyle = { height: 150, overflowY: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflowY: 'none' };

function voteButton(pollType, voteTypes, voteAction) {
  switch (pollType) {
    case 'signing': //2
      return (<SingleButton
        name={voteTypes[0].name}
        onClick={() => { voteAction(voteTypes.id); }}
      />);
    default:
      return voteTypes.map(voteType =>
        <SingleButton
          key={`${voteType.name}`}
          name={voteType.name}
          onClick={() => { voteAction(voteType.id); }}
        />
      );
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
    default:
      return voteTypes.map(voteType =>
        <VotedButton
          key={`${voteType.name}`}
          count={voteType.count}
          name={voteType.name}
          total={vote_count}
        />
      );
  }
}

function getPicture(picture) {
  // if (picture) {
  //   return picture
  // }
  return 'https://developers.google.com/experts/img/user/user-default.png';
}

const PollDetail = ({
  id, title, image, remaining,
  description, objective, vote_count,
  user_already_voted, links, politician,
  poll_type, moreInfo, setMoreInfo, vote_types,
  voteAction
}) => (
    <section id='poll-detail'>
    <div className='container'>
      <header className='row'>
        <p className='col-sm-12 poll-title'>
          { title }
        </p>
      </header>
      <section id='politician' className='row'>
          <img
            src={getPicture(politician.picture)}
            role='presentation'
            alt='politician'
          />
          <div id='author'>por {politician.full_name}</div>
      </section>
      <section id='poll' className='row'>
        <div className="col-sm-6">
          <img
            id='poll-thumbnail'
            src={image}
            role='presentation'
            alt='poll thumbnail'
          />
          <br /><br />
          <p id='objective' className='row'><strong> Objetivo: </strong> {objective}</p>
        </div>
        <div className="col-sm-6">
          <div className="row">
            <div className="poll-description-container col-sm-12">
               <p className="poll-description" style={moreInfo ? lessInfoStyle : moreInfoStyle}>
                { description }
              </p>
            </div>
            <div className="col-sm-12">
              <button onClick={setMoreInfo} id='plus-info'>
                { moreInfo ? '-INFO' : '+INFO' }
              </button>
            </div>
            <div className="col-sm-12">
              <div className="row">
                <div className="col-xs-9 buttons-wrapper">
                  { user_already_voted ? //eslint-disable-line
                      votedButton(poll_type, vote_types, vote_count) :
                      voteButton(poll_type, vote_types, voteAction)
                    }
                </div>
                <div className="countdown-wrapper col-xs-3">
                  <CountDown
                      timerCount={remaining}
                      countdownColor="#66CCCC"
                      innerColor="#fff"
                      outerColor="#747272"
                  />
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>
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
