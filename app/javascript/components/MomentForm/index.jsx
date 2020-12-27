import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { camelizeKeys, decamelizeKeys } from 'humps';

import { api } from '../../utils/api';

import Form from '../shared/Form';
import Input from '../shared/Input';
import Button from '../shared/Button';

const MomentForm = ({ trackId }) => {
  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [body, setBody] = useState('');

  const submitForm = () => {
    const data = decamelizeKeys({
      moment: {
        body,
      },
    });

    setIsSubmitting(true);
    setErrors({});
    api().post(`/tracks/${trackId}/moments`, data)
      .then(() => window.location.assign(`/tracks/${trackId}`))
      .catch((error) => {
        setErrors(camelizeKeys(error.response.data.errors));
        setIsSubmitting(false);
      });
  };

  return (
    <div className="row justify-content-center">
      <div className="col col-md-6">
        <Form id="moment_form">
          <Input
            id="body"
            clearErrors={setErrors}
            errors={errors.body}
            label="Describe your moment..."
            name="body"
            onChange={setBody}
            value={body}
          />
          <Button
            onClick={submitForm}
            isDisabled={isSubmitting}
          >
            Create Moment
          </Button>
        </Form>
      </div>
    </div>
  );
};

export default MomentForm;

MomentForm.defaultProps = {};

MomentForm.propTypes = {
  trackId: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number,
  ]).isRequired,
};

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('react-moment-form');
  const data = JSON.parse(node.getAttribute('data-camelized-props'));

  ReactDOM.render(
    <MomentForm {...data} />,
    node.appendChild(document.createElement('div')),
  );
});
