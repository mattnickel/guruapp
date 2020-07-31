import React from "react"
import PropTypes from "prop-types"
class Message extends React.Component {
  render () {
    return (
      <React.Fragment>
        Greeting: {this.props.greeting}
        
      </React.Fragment>
    );
  }
}

Message.propTypes = {
  greeting: PropTypes.string
};
export default Message
