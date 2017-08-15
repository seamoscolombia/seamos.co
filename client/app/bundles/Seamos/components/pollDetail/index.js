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


const shareUrl = `${PRODUCTION_URL}/facebookob/?Id=${window.location.hash}`; 
const { FacebookShareButton } = ShareButtons;
const { TwitterShareButton } = ShareButtons;
// const FacebookIcon = generateShareIcon('facebook');

const moreInfoStyle = { height: 150, overflow: 'hidden' };
const lessInfoStyle = { maxHeight: 9999, overflow: 'none' };

function getColorDependingOnTime(initial_time, remaining) {
  const startColor = '00FF92';
  const endColor = 'ff0000';
  const colorObj = new Color({ initial_time, remaining, startColor, endColor });
  return colorObj.interpolate();
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

function shareTitle(user_already_voted, poll_title) {
  if (user_already_voted) {
                            return `Yo ya voté, vota tú también por la propuesta: ${poll_title} en SeamOS`
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
    return <h4> Enlaces Externos </h4>;
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
                      voteAction, initial_time, tag
                    }) => (
    <section id='poll-detail'>
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
          <Link
            id='author'
            to={`/proponents/${politician.id}`}
          >por {politician.full_name}
          </Link>
          </section>
        <div className='share-wrapper'>
          <span className='share-this'> COMPARTIR: </span>
            <FacebookShareButton
              url={shareUrl}
              title={shareTitle(user_already_voted, title)}
              picture={image}
              description={description}
              className="network__share-button"
            >
              <a
                className='social-icon facebook-icon'
                style={{display: 'block'}}
                rel='noopener noreferrer'
              >
              </a>
                <br />
            </FacebookShareButton>
            <TwitterShareButton
              url={shareUrl}
              via='seamos'
              title={shareTitle(user_already_voted, title)}
              hashtags={[tag.name, 'seamos', 'democraciaDigital']}
              className="network__share-button"
            >
              <a
                className='social-icon twitter-icon'
                style={{display: 'block'}}
                rel='noopener noreferrer'
              >
              </a>
                <br />
            </TwitterShareButton>
        </div>
        <section id='poll' className='row'>
          <div className="col-sm-6">
            <img
              id='poll-thumbnail'
              src={image}
              role='presentation'
              alt='poll thumbnail'
            />
            <p id='objective' className='row'><strong> Objetivo: </strong> {objective}</p>
          </div>
          <div className="col-sm-6">
            <div className="row">
              <div className="poll-description-container col-sm-12">
                <div className="poll-description" style={moreInfo ? lessInfoStyle : moreInfoStyle}>
                  {description}
                  {externalLinksTitle(links)}
                  <div className='external-links-container'>
                    {externalLinks(links)}
                  </div>
                </div>
              </div>
              <div className="col-sm-12">
                <button onClick={setMoreInfo} id='plus-info'>
                  {moreInfo ? '-INFO' : '+INFO'}
                </button>
              </div>
              <div className="col-sm-12">
                <div className="row flex-row">
                  <div className="col-xs-8 buttons-wrapper">
                    {user_already_voted ? //eslint-disable-line
                      votedButton(poll_type, vote_types, vote_count) :
                      voteButton(poll_type, vote_types, voteAction)
                    }
                  </div>
                  <div className="col-xs-4">
                    <div className="countdown-wrapper">
                      { remaining > 0 ?
                        <CountDown
                            timerCount={remaining}
                            initialTime={initial_time}
                            countdownColor={getColorDependingOnTime(initial_time, remaining)}
                            innerColor="#fff"
                            outerColor="#747272"
                        /> :
                        <div className="closed-text-wrapper">
                          <h4> cerrada </h4>
                        </div>
                      }
                  </div>
                </div>
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
  tag: PropTypes.object.isRequired,
  vote_types: PropTypes.array,
  voteAction: PropTypes.func.isRequired
};

export default PollDetail;
