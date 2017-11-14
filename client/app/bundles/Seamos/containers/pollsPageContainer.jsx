// Simple example of a React 'smart' component
import React, { Component } from 'react';
import { connect } from 'react-redux';
import Polls from '../components/polls';
import { getPolls } from '../actions';

// Which part of the Redux global state does our component want to receive as props?
const mapStateToProps = (state) => {
    const { polls } = state;
    return { polls };
};

const mapDispatchToProps = { getPolls };

class PollsContainer extends Component {
    componentWillMount() {
        this.props.getPolls();
    }

    changeOpc(val) {
        this.props.getPolls(val.target.value);
    }
    render() {
        return (
            <div id='poll-page'>
              <div className='order-select-wrapper'>
                <span className='order-string'> Ordenar </span>
                <select name='' className='order-select' onChange={this.changeOpc.bind(this)}>
                    <option value='most-voted-first'> Propuestas más votadas </option>
                    <option value='newest-first'> Propuestas recientes </option>
                    <option value='nearest-closing-date-first'> Propuestas cercanas al cierre </option>
                    <option value='by-user-interests'> Propuestas según tus intereses </option>
                </select>
                <span className='polls-summary-text'> Resumen de propuestas </span>
                <span className='polls-summary-btn'> Ver + </span>
              </div>
              <Polls {...this.props} />
            </div>
        );
    }
}
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux 'connected' version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(mapStateToProps, mapDispatchToProps)(PollsContainer);
