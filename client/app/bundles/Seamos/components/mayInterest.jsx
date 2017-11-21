import React from 'react';
import Poll from './poll';
import OtherProfilePoll from './otherProfilePoll';

const MayInterest = ({ mayInterestReducer }) => (
  <div id='may-interest-container'>
    <div id='may-interest'>
      {console.log(mayInterestReducer)}
      {
        mayInterestReducer.map(
            poll => (
              <OtherProfilePoll {...poll} key={poll.id}/>
                    )
                )
      }
    </div>
  </div>
);

export default MayInterest;
