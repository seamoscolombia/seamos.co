// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Polls from '../components/polls';
import { pollsFilteredByTag } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { polls, tag } = state;
    return { polls, tag };
};

const mapDispatchToProps = { pollsFilteredByTag };

class RelatedPollsContainer extends Component {

    componentWillMount() {
        this.props.pollsFilteredByTag(this.props.tagId);
    }

    render() {
        const { polls, tag } = this.props; 
        if (polls.length !== 0 || this.props.tag) {
            return <Polls polls={polls.slice(0, 2)} tag={tag} />;
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(RelatedPollsContainer);
