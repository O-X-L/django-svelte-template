import { mount } from 'svelte';

import App from './App.svelte'

const test = mount(App, {
  target: document.getElementById('app-test'),
})

export default test
