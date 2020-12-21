import React from 'react';
import PropTypes from 'prop-types';

const Input = (props) => {
  const {
    id,
    isDisabled,
    hasError,
    helpText,
    label,
    name,
    onChange,
    placeholder,
    value,
  } = props;

  return (
    <div className="form-group">
      <label htmlFor={id}>
        {label}
      </label>
      <input
        id={id}
        disable={isDisabled}
        name={name}
        type="text"
        className="form-control"
        value={value}
        placeholder={placeholder}
        onChange={(e) => onChange(e.target.value)}
      />
      {helpText && (
        <small className="form-text text-muted">
          {helpText}
        </small>
      )}
    </div>
  );
};

Input.defaultProps = {
  id: '',
  isDisabled: null,
  hasError: false,
  helpText: null,
  label: '',
  placeholder: '',
  value: '',
};

Input.propTypes = {
  id: PropTypes.string,
  isDisabled: PropTypes.bool,
  hasError: PropTypes.bool,
  helpText: PropTypes.string,
  label: PropTypes.string,
  name: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  placeholder: PropTypes.string,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
};

export default Input;
