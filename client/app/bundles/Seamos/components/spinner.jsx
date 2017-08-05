import React from 'react';

const Spinner = ({ isFetching }) => (
  <div>
  { isFetching ? <div id='spinner-container'><div id='spinner' /></div> : <span /> }
  </div>
);

export default Spinner;
