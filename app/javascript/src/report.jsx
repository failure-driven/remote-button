import React from "react";
/* eslint-disable import/no-unresolved */
import PropTypes from "prop-types";
import Highcharts from "highcharts";
import HighchartsReact from "highcharts-react-official";

const Report = ({ reports }) => {
  const data = {
    title: { text: "Daily Count" },
    xAxis: { type: "datetime" },
    yAxis: { title: { text: "Count" } },
    series: [{ type: "column", data: reports }],
  };
  return <HighchartsReact highcharts={Highcharts} options={data} />;
};

Report.propTypes = {
  reports: PropTypes.arrayOf.isRequired,
};

export default Report;
