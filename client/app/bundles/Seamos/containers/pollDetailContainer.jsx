// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import PollDetail from '../components/pollDetail';
import { getPoll, votePoll } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { poll, session } = state;
    return { poll, session };
};

const mapDispatchToProps = { getPoll, votePoll };

class PollsDetailContainer extends Component {
    constructor(props) {
        super(props);
        this.state = { moreInfo: false, timer: 0 };
        this.setMoreInfo = this.setMoreInfo.bind(this);
        this.voteAction = this.voteAction.bind(this);
    }

    componentWillMount() {
        this.props.getPoll({ 
            pollId: this.props.match.params.pollId,
            errCallback: () => this.props.history.push('/404')
        });
    }

    setMoreInfo() { this.setState({ moreInfo: !this.state.moreInfo }); }
    voteAction(id) { 
        const { poll, session, votePoll } = this.props;
        if (session.authenticityToken) {
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
        const { poll } = this.props;
        if (poll.id) {
            return (
                <PollDetail
                    {...this.props.poll}
                    setMoreInfo={this.setMoreInfo}
                    moreInfo={this.state.moreInfo}
                    voteAction={id => this.voteAction(id)}
                />
            );
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsDetailContainer);
