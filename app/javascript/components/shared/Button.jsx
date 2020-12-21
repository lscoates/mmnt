import React from 'react';
import PropTypes from 'prop-types';

const Button = (props) => {
  const {
    isDisabled,
    children,
    onClick,
  } = props;

  const handleClick = (e) => {
    e.preventDefault();
    e.stopPropagation();
    onClick(e);
  };

  return (
    <button
      type="submit"
      className="btn btn-primary"
      disabled={isDisabled}
      onClick={handleClick}
    >
      {children}
    </button>
  );
};

Button.defaultProps = {
  isDisabled: false,
  onClick: null,
};

Button.propTypes = {
  children: PropTypes.oneOfType([
    PropTypes.arrayOf(PropTypes.node),
    PropTypes.node,
  ]).isRequired,
  isDisabled: PropTypes.bool,
  onClick: PropTypes.func,
};

export default Button;
