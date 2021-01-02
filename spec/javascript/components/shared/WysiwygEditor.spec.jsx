import React from 'react';

import { shallow, configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
import { TrixEditor } from 'react-trix';
import WysiwygEditor from 'shared/WysiwygEditor';

configure({ adapter: new Adapter() });

describe('WysiwygEditor', () => {
  it('renders the TrixEditor component', () => {
    const wrapper = shallow(
      <WysiwygEditor
        onChange={() => {}}
      />,
    );

    expect(wrapper.find(TrixEditor).exists()).toEqual(true);
  });

  it('renders a label when provided', () => {
    const wrapper = shallow(
      <WysiwygEditor
        id="moment"
        label="Moment"
        onChange={() => {}}
      />,
    );

    expect(wrapper.containsMatchingElement(
      <label htmlFor="moment">Moment</label>,
    )).toEqual(true);
  });

  it('renders errors when provided', () => {
    const wrapper = shallow(
      <WysiwygEditor
        errors={["can't be blank"]}
        onChange={() => {}}
      />,
    );

    expect(wrapper.containsMatchingElement(
      <div className="invalid-feedback">can&apos;t be blank</div>,
    )).toEqual(true);
  });
});
