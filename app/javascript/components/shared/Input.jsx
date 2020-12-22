import React from 'react';
import PropTypes from 'prop-types';

const Input = (props) => {
  const {
    errors,
    id,
    isDisabled,
    helpText,
    label,
    name,
    onChange,
    placeholder,
    value,
  } = props;

  const classes = `form-control ${errors ? 'is-invalid' : ''}`;

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
        className={classes}
        value={value}
        placeholder={placeholder}
        onChange={(e) => onChange(e.target.value)}
      />
      {errors && (
        <div className="invalid-feedback">
          {errors}
        </div>
      )}
      {helpText && (
        <small className="form-text text-muted">
          {helpText}
        </small>
      )}
    </div>
  );
};

Input.defaultProps = {
  errors: null,
  id: '',
  isDisabled: null,
  helpText: null,
  label: '',
  placeholder: '',
  value: '',
};

Input.propTypes = {
  errors: PropTypes.arrayOf(PropTypes.string),
  id: PropTypes.string,
  isDisabled: PropTypes.bool,
  helpText: PropTypes.string,
  label: PropTypes.string,
  name: PropTypes.string.isRequired,
  onChange: PropTypes.func.isRequired,
  placeholder: PropTypes.string,
  value: PropTypes.oneOfType([PropTypes.string, PropTypes.number]),
};

export default Input;
