// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import SelectInterests from '../components/selectInterests';
import { getInterests, userInterests, updateInterestsShow } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { session, tags, user } = state;
    return { session, tags, user };
};

const mapDispatchToProps = { getInterests, userInterests, updateInterestsShow };

class SelectInterestsContainer extends Component {
    constructor(props) {
        super(props);
        this.selectInterest = this.selectInterest.bind(this);
        this.returnToMySubjects = this.returnToMySubjects.bind(this);
    }

    componentDidMount() {
        this.props.getInterests(this.props.user.id);
    }

    selectInterest(tag) {
        const { session, user, userInterests } = this.props;
        userInterests({ 
            authenticity_token: session.authenticityToken,
            user_id: user.id,
            tag
        });
    }

    returnToMySubjects() {
        this.props.updateInterestsShow();
    }

    render() {
        const { tags } = this.props;
        if (tags.length !== 0) {
            return (<SelectInterests 
                tags={tags} 
                action={this.selectInterest} 
                returnToMySubjects={this.returnToMySubjects}
            />);
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(SelectInterestsContainer);
