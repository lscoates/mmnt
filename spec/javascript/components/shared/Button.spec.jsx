import React from 'react';

import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import Button from 'shared/Button';

configure({ adapter: new Adapter() });

test('renders the component with the required props', () => {
  const wrapper = shallow(<Button>Submit</Button>);

  expect(wrapper.containsMatchingElement(
    <button />,
  ));
  expect(wrapper.text()).toEqual('Submit');
});
