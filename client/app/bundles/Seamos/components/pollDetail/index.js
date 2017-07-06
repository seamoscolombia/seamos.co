import PropTypes from 'prop-types';
import React from 'react';

import CountDown from '../../containers/countdownContainer';
import Color from '../../utils/color';
import SingleButton from './singleButton';
import VotedButton from './votedButton';

const moreInfoStyle = { height: 150, overflowY: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflowY: 'none' };

function getColorDependingOnTime(initial_time, remaining) {
  const startColor = '00FF92';
  const endColor = 'ff0000';
  const colorObj = new Color({ initial_time, remaining, startColor, endColor });
  return colorObj.interpolate();
}
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

function getPicture(politician) {
  if (politician.picture) {
    return politician.picture
  }
  return 'https://developers.google.com/experts/img/user/user-default.png';
}

const PollDetail = ({
  id, title, image, remaining,
  description, objective, vote_count,
  user_already_voted, links, politician,
  poll_type, moreInfo, setMoreInfo, vote_types,
  voteAction, initial_time
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
            src={getPicture(politician)}
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
                  { user_already_voted || remaining < 0? //eslint-disable-line
                      votedButton(poll_type, vote_types, vote_count) :
                      voteButton(poll_type, vote_types, voteAction)
                    }
                </div>
                <div className="countdown-wrapper col-xs-3">
                  { remaining > 0 ?
                    <CountDown
                        timerCount={remaining}
                        initialTime={initial_time}
                        countdownColor={getColorDependingOnTime(initial_time, remaining)}
                        innerColor="#fff"
                        outerColor="#747272"
                    /> :
                    <h4> Propuesta cerrada </h4>
                  }
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
  initial_time: PropTypes.number.isRequired,
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
