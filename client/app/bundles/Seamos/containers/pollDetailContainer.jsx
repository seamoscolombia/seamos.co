// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import PollDetail from '../components/pollDetail';
import { getPoll, votePoll, chechVotedPol, validateSession } from '../actions';


// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { poll, session, user } = state;
    return { poll, session, user };
};

const mapDispatchToProps = { getPoll, votePoll, chechVotedPol, validateSession };

class PollsDetailContainer extends Component {
    constructor(props) {
        super(props);
        this.state = { moreInfo: false, timer: 0 };
        this.setMoreInfo = this.setMoreInfo.bind(this);
        this.voteAction = this.voteAction.bind(this);
    }

    componentWillMount() {
        this.props.validateSession();        
        this.props.getPoll({
            pollId: this.props.match.params.pollId,
            errCallback: () => this.props.history.push('/404')
        });
    }

    shouldComponentUpdate(nextProps) {
      if (!nextProps.user.id) {
        this.props.poll.user_already_voted = false;
        this.props.poll.prevent_loop = true;
      } else if (nextProps.user.id && nextProps.poll.id && nextProps.poll.prevent_loop) {
        this.props.chechVotedPol(nextProps.user.id, nextProps.poll);
      } else if (nextProps.poll.id !== this.props.poll.id) {
          window.location.hash = `/poll/${nextProps.poll.id}`;
          console.info('new poll detail', nextProps.poll.id);
      } else if (nextProps.match.params.pollId !== this.props.match.params.pollId) {
         this.props.getPoll({
              pollId: nextProps.match.params.pollId,
              errCallback: () => this.props.history.push('/404')
          });
      }
      return true;
    }

    componentWillUnmount() {
      this.props.poll.id = null;
    }

    setMoreInfo() { this.setState({ moreInfo: !this.state.moreInfo }); }

    voteAction(id) {
        const { poll, session, votePoll } = this.props;

        if (session.logged) {
            votePoll({
                voteTypeId: id,
                authenticityToken: session.authenticityToken,
                poll
            });
        } else {            
            alert('Por favor inicie sesión antes de votar'); //eslint-disable-line
        }
    }

    render() {
        const { poll, session } = this.props;
        if (poll.id) {
            return (
                <div>
                    <PollDetail
                        {...this.props.poll}
                        setMoreInfo={this.setMoreInfo}
                        moreInfo={this.state.moreInfo}
                        voteAction={id => this.voteAction(id)}
                        session={session}
                    /> 
                </div>
            );
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsDetailContainer);
