import React from 'react';
import PropTypes from 'prop-types';

const Form = (props) => {
  const { children, id } = props;

  return (
    <form id={id}>
      {children}
    </form>
  );
};

Form.defaultProps = {
  id: '',
};

Form.propTypes = {
  id: PropTypes.string,
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.node),
    PropTypes.node,
  ]).isRequired,
};

export default Form;
