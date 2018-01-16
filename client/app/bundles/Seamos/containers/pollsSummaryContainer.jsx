// Simple example of a React "smart" component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import MayInterest from '../components/mayInterest';
import { getSummaryPolls } from '../actions';

const mapStateToProps = (state) => {
    const { mayInterestReducer } = state;
    return { mayInterestReducer };
};

const mapDispatchToProps = { getSummaryPolls };

class PollsSummaryContainer extends Component {
    componentWillMount() {
      this.props.getSummaryPolls();
    }

    render() {
      return(
        <div id='polls-summary-container'>
          <div className='row summary-header'>
            Resumen de Propuestas
          </div>
          <MayInterest {...this.props} />;
        </div>
      )
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsSummaryContainer);
