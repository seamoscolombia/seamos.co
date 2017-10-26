import React from 'react';
import Poll from './poll';


const MayInterest = ({ mayInterestReducer }) => (
  <div id='may-interest'>
    <div className='row interest-banner one'>
      Tambien te puede interesar
    </div>
    <div className='row'>
      {console.log(mayInterestReducer)}
      {
        mayInterestReducer.map(
            poll => (
              <Poll {...poll} key={poll.id} />
                    )
                )
      }
    </div>
  </div>
);

export default MayInterest;
