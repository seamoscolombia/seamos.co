// Simple example of a React "smart" component
import { connect } from 'react-redux';
import Poll from '../components/poll';
import { pollsFilteredByTag } from '../actions';

const mapDispatchToProps = { pollsFilteredByTag };
// Don't forget to actually use connect!
// Note that we don't export Polls, but the redux "connected" version of it.
// See https://github.com/reactjs/react-redux/blob/master/docs/api.md#examples
export default connect(null, mapDispatchToProps)(Poll);