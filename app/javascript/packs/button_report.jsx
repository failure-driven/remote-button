import React from 'react';
import ReactDOM from 'react-dom';
import Report from '../src/report';

document.addEventListener('DOMContentLoaded', () => {
  const node = document.getElementById('reports_data');
  const data = JSON.parse(node.getAttribute('data'));
  ReactDOM.render(
    <Report reports={data} />,
    document.body.appendChild(document.createElement('div')),
  );
});
