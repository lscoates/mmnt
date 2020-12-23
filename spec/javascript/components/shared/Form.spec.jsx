import React from 'react';

import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import Form from 'shared/Form';

configure({ adapter: new Adapter() });

test('renders the component with the required props', () => {
  const wrapper = shallow(<Form>Create</Form>);

  expect(wrapper.containsMatchingElement(
    <form />,
  ));
  expect(wrapper.text()).toEqual('Create');
});
