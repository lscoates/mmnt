import React, { useEffect } from 'react';
import PropTypes from 'prop-types';
import { TrixEditor } from 'react-trix';

const WysiwygEditor = (props) => {
  const {
    id,
    errors,
    helpText,
    label,
    onChange,
  } = props;

  useEffect(() => {
    window.addEventListener('trix-file-accept', (event) => {
      event.preventDefault();
      alert('File attachment is not currently supported!');
    });

    return () => {
      window.removeEventListener('trix-file-accept');
    };
  });

  const handleChange = (html) => {
    onChange(html);
  };

  return (
    <div className="form-group">
      <label htmlFor={id}>
        {label}
      </label>
      <TrixEditor
        onChange={handleChange}
      />
      {errors && (
        <div className="invalid-feedback" style={{ display: 'block' }}>
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

WysiwygEditor.defaultProps = {
  id: '',
  errors: null,
  helpText: null,
  label: '',
};

WysiwygEditor.propTypes = {
  id: PropTypes.string,
  errors: PropTypes.arrayOf(PropTypes.string),
  helpText: PropTypes.string,
  label: PropTypes.string,
  onChange: PropTypes.func.isRequired,
};

export default WysiwygEditor;
