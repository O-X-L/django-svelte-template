import { mount } from 'svelte';

import './app.css'
import App from './App.svelte'

const main = mount(App, {
  target: document.getElementById('app'),
})

export default main
