import React from 'react';

import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import { SingleDatePicker } from 'react-dates';
import DatePicker from 'shared/DatePicker';

configure({ adapter: new Adapter() });

describe('DatePicker', () => {
  it('renders the SingleDatePicker component', () => {
    const wrapper = shallow(
      <DatePicker
        id="date_picker"
        setDate={() => {}}
      />,
    );

    expect(wrapper.find(SingleDatePicker).exists()).toEqual(true);
  });

  it('renders a label when provided', () => {
    const wrapper = shallow(
      <DatePicker
        id="date_picker"
        label="Date"
        setDate={() => {}}
      />,
    );

    expect(wrapper.containsMatchingElement(
      <label htmlFor="date_picker">Date</label>,
    )).toEqual(true);
  });
});
