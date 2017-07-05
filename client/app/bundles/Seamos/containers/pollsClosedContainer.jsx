// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Polls from '../components/polls';
import { getClosedPolls } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { polls } = state;
    return { polls };
};

const mapDispatchToProps = { getClosedPolls };

class PollsContainer extends Component {
    componentWillMount() {
        this.props.getClosedPolls();
    }

    render() {
        return (
            <div id="closed-polls">
                <Polls {...this.props} />
            </div>
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsContainer);
