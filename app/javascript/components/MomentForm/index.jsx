import React, { useState } from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import { camelizeKeys, decamelizeKeys } from 'humps';
import moment from 'moment';

import { api } from '../../utils/api';

import Form from '../shared/Form';
import Input from '../shared/Input';
import Button from '../shared/Button';
import DatePicker from '../shared/DatePicker';
import WysiwygEditor from '../shared/WysiwygEditor';

const MomentForm = ({ trackId }) => {
  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [title, setTitle] = useState('');
  const [body, setBody] = useState('');
  const [originalDate, setOriginalDate] = useState(moment().format());

  const submitForm = () => {
    const data = decamelizeKeys({
      moment: {
        title,
        body,
        originalDate,
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
            id="title"
            clearErrors={setErrors}
            errors={errors.title}
            label="Title"
            name="title"
            onChange={setTitle}
            value={title}
          />

          <WysiwygEditor
            id="body"
            errors={errors.body}
            label="Describe your moment..."
            onChange={setBody}
          />

          <DatePicker
            id="original_date"
            date={originalDate}
            label="When did it happen?"
            setDate={setOriginalDate}
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
