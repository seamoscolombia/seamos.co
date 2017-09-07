import React, { Component } from 'react';
import { connect } from 'react-redux';

import { updateInput } from '../actions';

const mapStateToProps = state => {
  console.log(state);
};

const mapDispatchToProps = { updateInput };

class InputContainer extends Component {
  constructor(props) {
    super(props);
    this.handleInput = this.handleInput.bind(this);
  }

  handleInput(title, name, e) {
    this.props.updateInput(title, name, e.target.value);
  }

  render() {
    return (
      <div className="input-group">
        <input type="text" className="form-control" placeholder={this.props.placeholder} 
          onChange={(e) => this.handleInput(this.props.title, this.props.name, e)} 
        />
        <span className="input-group-btn">
          <button className="btn btn-secondary" type="button" onClick={this.props.actionCreator}>
            ENVIAR
          </button>
        </span>
      </div>
    );
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(InputContainer);
