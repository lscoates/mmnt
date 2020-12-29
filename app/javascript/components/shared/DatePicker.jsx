import React, { useState } from 'react';
import PropTypes from 'prop-types';
import 'react-dates/initialize';
import { SingleDatePicker } from 'react-dates';
import moment from 'moment';

const DatePicker = ({
  id,
  date,
  label,
  setDate,
}) => {
  const [focused, setFocused] = useState(false);

  const handleDateChange = (momentDate) => {
    setDate(momentDate.format());
  };

  const outsideRange = (selectedDate) => (
    selectedDate.isAfter(moment())
  );

  return (
    <div className="form-group">
      <label htmlFor={id}>
        {label}
      </label>
      <br />
      <SingleDatePicker
        date={moment(date)}
        onDateChange={handleDateChange}
        focused={focused}
        onFocusChange={() => setFocused(!focused)}
        id={id}
        isOutsideRange={(selectedDate) => outsideRange(selectedDate)}
        numberOfMonths={1}
        withPortal
      />
    </div>
  );
};

export default DatePicker;

DatePicker.defaultProps = {
  date: moment().format(),
  label: '',
};

DatePicker.propTypes = {
  id: PropTypes.string.isRequired,
  date: PropTypes.string,
  label: PropTypes.string,
  setDate: PropTypes.func.isRequired,
};
