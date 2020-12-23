import React from 'react';

import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import Input from 'shared/Input';

configure({ adapter: new Adapter() });

test('renders the component with the required props', () => {
  const wrapper = shallow(<Input
    id="name"
    clearErrors={null}
    errors={["can't be blank"]}
    helpText="help text"
    label="Name"
    name="name"
    onChange={() => null}
    value={null}
  />);
  const label = wrapper.find('label');
  const errors = wrapper.find('div.invalid-feedback');
  const helpText = wrapper.find('small');

  expect(wrapper.containsMatchingElement(
    <input />,
  ));
  expect(label.text()).toEqual('Name');
  expect(errors.text()).toEqual("can't be blank");
  expect(helpText.text()).toEqual('help text');
});
