import React from "react";
import ReactDOM from "react-dom";
import Report from "../src/report.jsx";

document.addEventListener("turbolinks:load", () => {
  const node = document.getElementById("button-raw-report");
  const data = JSON.parse(node.getAttribute("data"));
  ReactDOM.render(
    <Report reports={data} />,
    document.getElementById("button-raw-report")
  );
});
