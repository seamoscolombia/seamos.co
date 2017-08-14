// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import Tags from '../components/tags';
import { getTags } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { tags } = state;
    return { tags };
};

const mapDispatchToProps = { getTags };
class TagsContainer extends Component {
    componentWillMount() {
        this.props.getTags();
    }
    pollsByTag(props) {
        const id = props.id;
        this.props.history.push(`/tag/${id}/polls`);
    }
    render() {
        return (
            <div id='tags-page'>
              <div className='background-container'>
                <div className='flex-container'>
                  <h1 className='question'>
                    Encuentra propuestas de <br className='breaker' />
                    acuerdo a los temas<br className='breaker' />
                    de tu interés
                  </h1>
                </div>
              </div>
              <div>
                  <Tags {...this.props} action={this.pollsByTag.bind(this)} />
              </div>
            </div>
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default withRouter(connect(mapStateToProps, mapDispatchToProps)(TagsContainer));
