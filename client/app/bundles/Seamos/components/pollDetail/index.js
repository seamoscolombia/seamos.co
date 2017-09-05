import PropTypes from 'prop-types';
import React from 'react';

import { ShareButtons } from 'react-share';
import { Link } from 'react-router-dom';
import CountDown from '../../containers/countdownContainer';
import RelatedPolls from './../../containers/relatedPollsContainer';
import Color from '../../utils/color';
import SingleButton from './singleButton';
import VotedButton from './votedButton';
import { PRODUCTION_URL } from '../../constants';

import FacebookLogin from '../../containers/facebookLoginContainer';


const shareUrl = `${PRODUCTION_URL}/facebookob/?id=`;
// const twittershareUrl = `${PRODUCTION_URL}/#/poll/`;
const { FacebookShareButton } = ShareButtons;
const { TwitterShareButton } = ShareButtons;
// const FacebookIcon = generateShareIcon('facebook');

const moreInfoStyle = { height: 150, overflow: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflow: 'none' };
const statusActiveStyle = { backgroundColor: 'yellow' };
const statusInactiveStyle = { backgroundColor: 'gainsboro' };



function getColorDependingOnTime(initial_time, remaining) {
  const startColor = '00FF92';
  const endColor = 'ff0000';
  const colorObj = new Color({ initial_time, remaining, startColor, endColor });
  return colorObj.interpolate();
}

function getDays(remaining) {
  const remainingDays = ((remaining / 3600) / 24);
  if (remainingDays < 0) {
    return <span> propuesta cerrada</span>;
  } else if (remaining < 3600 && remaining > 0) {
    return <span> faltan {Math.round(remaining / 60)} minutos</span>;
  } else if (remaining < 86400) {
    return <span> faltan {Math.round(remaining / 3600)} horas</span>;
  }
  return <span> faltan {Math.round(remainingDays)} días</span>;
}

function externalLinks(links) {
  return links.map(link =>
    <div className='external-link'>
      <a
        href={link.url}
        target='_blank'
        rel='noopener noreferrer'
      >
        {link.url.substr(0, 60)}
      </a>
    </div>
  );
}

function voteButton(pollType, voteTypes, voteAction, session) {
  switch (pollType) {
    case 'signing': //2
      return (<SingleButton
        name={voteTypes[0].name}
        onClick={() => { voteAction(voteTypes.id); }}
      />);
    default:
      console.log(session);
      if (!session.logged) {
        return voteTypes.map(voteType =>
          <FacebookLogin
            key={`${voteType.name}`} fbclassName='btn single-button non-voted-button'
            fbText={voteType.name}
          />
        );
      } else {
        return voteTypes.map(voteType =>
          <SingleButton
            key={`${voteType.name}`}
            name={voteType.name}
            onClick={() => { voteAction(voteType.id); }}
          />
        );
      }
  }
}

function shareTitle(user_already_voted, poll_title) {
  if (user_already_voted) {
                            return `Ya voté, vota por la propuesta: ${poll_title} en SeamOS`
                          }
                          return `Vota por la propuesta: ${poll_title} en SeamOS`
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

function externalLinksTitle(links) {
  const linksPresent = links.length !== 0;
  if (linksPresent) {
    return <h5> Enlaces Externos </h5>;
  }
  return null;
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
                      voteAction, initial_time, tag, status, summary, session
                    }) => (
    <div>
      <section id='poll-detail'>
        <div className="top-color-bar" style={{ backgroundColor: tag.color }} >
          <div className="tag-name"> {tag.name} </div>
        </div>
        <div className='container'>
          <header className='row'>
            <p className='col-sm-12 poll-title'>
              {title}
            </p>
          </header>
          <section id='politician' className='row'>
            <img
              src={getPicture(politician)}
              role='presentation'
              alt='politician'
            />
            <div id='politician-info'>
              <Link
                id='author'
                to={`/proponents/${politician.id}`}
              > {politician.full_name}
              </Link>
              <div id='org'> {politician.organization} </div>
            </div>
          </section>
          <div className='share-wrapper'>
            <span className='share-this'> COMPARTIR: </span>
              <FacebookShareButton
                url={shareUrl + id}
                className="network__share-button"
              >
                <a
                  className='fa fa-facebook'
                  style={{display: 'block'}}
                  rel='noopener noreferrer'
                >
                </a>
                  <br />
              </FacebookShareButton>
              <TwitterShareButton
                url={shareUrl + id}
                via='seamos'
                title={shareTitle(user_already_voted, title)}
                hashtags={['seamOSelcambio']}
                className="network__share-button"
              >
                <a
                  className='fa fa-twitter'
                  style={{display: 'block'}}
                  rel='noopener noreferrer'
                >
                </a>
                  <br />
              </TwitterShareButton>
          </div>
          <section id='poll' className='row'>
            <div id='left-col' className="col-sm-6">
              <img
                id='poll-thumbnail'
                src={image}
                role='presentation'
                alt='poll thumbnail'
              />
              <p id='objective' className='row' style={{display: 'none'}}><strong> Objetivo: </strong> {objective}</p>
              <div id='poll-states'>
                <div className='state state-1' style={(remaining > 0 && status === 0) ? statusActiveStyle : statusInactiveStyle}> Votación abierta </div>
                <div className='state state-2' style={(remaining > 0 && status === 1) ? statusActiveStyle : statusInactiveStyle}> En el concejo </div>
                <div className='state state-3' style={(remaining > 0 && status === 2) ? statusActiveStyle : statusInactiveStyle}> Proyecto de acuerdo </div>
                <div className='state state-4' style={(remaining > 0 && status === 3) ? statusActiveStyle : statusInactiveStyle}> En el concejo </div>
                <div className='state state-5' style={remaining < 0 ? statusActiveStyle : statusInactiveStyle}> Propuesta Cerrada </div>
              </div>
              {externalLinksTitle(links)}
              <div className='external-links-container'>
                {externalLinks(links)}
              </div>
            </div>
            <div className="col-sm-6">
              <div className="row">
                <div className="col-sm-12">
                  <div className="row">
                    <div className='summary'> {summary} </div>
                    <div className="col-xs-12 col-sm-12 buttons-wrapper">
                      {user_already_voted || remaining <= 0 ?
                        votedButton(poll_type, vote_types, vote_count) :
                        voteButton(poll_type, vote_types, voteAction, session)
                      }
                    </div>
                    <div className='col-xs-12 col-sm-12 poll-details'>
                        { getDays(remaining) }
                    </div>
                  </div>
                </div>
                <div className="poll-description-container col-sm-12">
                  <div className="poll-static-title"> La Propuesta: </div>
                  <div dangerouslySetInnerHTML={{ __html: description }} className="poll-description" style={lessInfoStyle}>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
        <div id='related-polls'>
          <RelatedPolls tagId={tag.id} pollId={id} />
        </div>
      </section>
    </div>
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
  user_already_voted: PropTypes.bool.isRequired,
  links: PropTypes.array.isRequired,
  politician: PropTypes.object.isRequired,
  moreInfo: PropTypes.bool,
  tag: PropTypes.object.isRequired,
  vote_types: PropTypes.array,
  voteAction: PropTypes.func.isRequired,
  session: PropTypes.object
};

export default PollDetail;
