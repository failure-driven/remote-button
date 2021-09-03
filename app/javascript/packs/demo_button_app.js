import DemoButtonApp from '../src/svelte/DemoButtonApp.svelte';

let element = document.querySelector('[data-app=demo-button-app]');
if (!element) {
  element = document.createElement('div');
  element.setAttribute('data-app', 'demo-button-app');
  document.body.appendChild(element);
}
const demoButtonApp = (function (my) { // eslint-disable-line func-names
  my.app = () => { // eslint-disable-line no-param-reassign
    const app = new DemoButtonApp({
      target: element,
      props: {
        dataset: {
          config: JSON.parse(element.dataset.config),
        },
      },
    });

    window.app = app;
    return app;
  };
  return (my);
}(demoButtonApp || {})); // eslint-disable-line no-use-before-define

window.demoButtonApp = demoButtonApp;

document.addEventListener('DOMContentLoaded', () => {
  window.demoButtonApp.app();
});
