import axios from 'axios';

export const csrfToken = () => {
  try {
    return document.head.querySelector('[name=csrf-token]').content;
  } catch (e) {
    return '';
  }
};

const defaultHeaders = {
  Accept: 'application/json',
  'Content-Type': 'application/json',
  'X-CSRF-Token': csrfToken(),
};

export const api = () => (
  axios.create({
    headers: defaultHeaders,
  })
);
