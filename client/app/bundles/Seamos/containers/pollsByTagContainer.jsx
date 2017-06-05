// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import PollsByTag from '../components/pollsByTag';
import { pollsFilteredByTag } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { polls } = state;
    return { polls };
};

const mapDispatchToProps = { pollsFilteredByTag };

class PollsByTagContainer extends Component {

    componentWillMount() {
        this.props.pollsFilteredByTag(this.props.match.params.tagId);
    }

    render() {
        return <PollsByTag {...this.props} />;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsByTagContainer);
