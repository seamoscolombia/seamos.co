// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import PollDetail from '../components/pollDetail/index';
import { getPoll } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { poll } = state;
    return { poll };
};

const mapDispatchToProps = { getPoll };

class PollsDetailContainer extends Component {
    constructor(props) {
        super(props);
        this.state = { moreInfo: false, remainingTime: '', seconds: 0 };
        this.setMoreInfo = this.setMoreInfo.bind(this);
    }

    componentWillMount() {
        this.props.getPoll(this.props.match.params.pollId);
    }

    // shouldComponentUpdate(nextProps, nextState) {
    //     if (nextProps.remaining !== 0) { return true; }
    //     return false;
    // }
    componentDidMount() {
        setInterval(this.countdown(), 1000);
    }

    setMoreInfo() { this.setState({ moreInfo: !this.state.moreInfo }); }

    countdown() {
        const seconds = this.state.seconds - 1;
        if (seconds !== 0) {
            this.setState({
                remainingTime: this.secondsToTime(seconds),
                seconds,
            });
        }
    }
    secondsToTime(secs) {
        const days = secs / 86400;
        if (days < 1) {
            return `${Math.floor(days)}`;
        }
    }

    render() {
        return (
            <PollDetail
                {...this.props.poll}
                setMoreInfo={this.setMoreInfo}
                moreInfo={this.state.moreInfo}
                remainingTime={this.state.remainingTime}
            />
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsDetailContainer);
