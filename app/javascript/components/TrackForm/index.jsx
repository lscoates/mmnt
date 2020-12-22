import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { camelizeKeys, decamelizeKeys } from 'humps';

import { api } from '../../utils/api';

import Form from '../shared/Form';
import Input from '../shared/Input';
import Button from '../shared/Button';

const TrackForm = () => {
  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [name, setName] = useState('');

  const submitForm = () => {
    const data = decamelizeKeys({
      track: {
        name,
      },
    });

    setIsSubmitting(true);
    setErrors({});
    api().post('/tracks', data)
      .then(() => window.location.assign('/tracks'))
      .catch((error) => {
        setErrors(camelizeKeys(error.response.data.errors));
        setIsSubmitting(false);
      });
  };

  return (
    <div className="row justify-content-center">
      <div className="col col-md-6">
        <Form id="track_form">
          <Input
            id="name"
            clearErrors={setErrors}
            errors={errors.name}
            label="Name"
            name="name"
            onChange={setName}
            value={name}
          />
          <Button
            onClick={submitForm}
            isDisabled={isSubmitting}
          >
            Create Track
          </Button>
        </Form>
      </div>
    </div>
  );
};

TrackForm.defaultProps = {};

TrackForm.propTypes = {};

export default TrackForm;

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('react-track-form');
  const data = JSON.parse(node.getAttribute('data-camelized-props'));

  ReactDOM.render(
    <TrackForm {...data} />,
    node.appendChild(document.createElement('div')),
  );
});
