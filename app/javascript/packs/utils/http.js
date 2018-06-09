import axios from 'axios';
export const HTTP = axios.create({
  baseURL: '/',
  headers: {
    'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }
});
