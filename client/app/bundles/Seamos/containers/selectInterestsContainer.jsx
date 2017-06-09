// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import SelectInterests from '../components/selectInterests';
import { getInterests, userInterests } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { session, tags, user } = state;
    return { session, tags, user };
};

const mapDispatchToProps = { getInterests, userInterests };

class ProfileContainer extends Component {

    componentDidMount() {
        this.props.getInterests();
    }

    selectInterest(tag) {
        const { session, user, userInterests } = this.props;
        userInterests({ 
            authenticity_token: session.authenticityToken,
            user_id: user.id,
            tag
        });
    }

    render() {
        const { tags } = this.props;
        if (tags.length !== 0) {
            return <SelectInterests tags={tags} action={this.selectInterest.bind(this)} />;
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(ProfileContainer);
