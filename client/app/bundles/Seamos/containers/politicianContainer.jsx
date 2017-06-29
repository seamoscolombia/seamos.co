// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getPolitician } from '../actions';
import Politician from '../components/politician';
// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { politician } = state;
    return { politician };
};

const mapDispatchToProps = { getPolitician };

class ProfileContainer extends Component {

    componentWillMount() {
        const politicianId = this.props.match.params.politicianId;
        this.props.getPolitician(politicianId);
    }
        
    render() {
        const { politician } = this.props;
        if (politician.id !== null) {
            return <Politician {...politician} />;
        }
        return null;
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(ProfileContainer);
