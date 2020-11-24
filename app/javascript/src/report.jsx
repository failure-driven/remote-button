import React from 'react';
/* eslint-disable import/no-unresolved */
import PropTypes from 'prop-types';
import Highcharts from 'highcharts';
import HighchartsReact from 'highcharts-react-official';

const Report = ({ reports }) => {
  const data = { title: { text: 'Widget X' }, xAxis: { type: 'datetime' }, series: [{ data: reports }] };
  return <HighchartsReact highcharts={Highcharts} options={data} />;
};

Report.propTypes = {
  reports: PropTypes.arrayOf.isRequired,
};

export default Report;
