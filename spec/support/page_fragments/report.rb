module PageFragments
  module Report
    def report_totals
      report.find("[data-testid=\"report-total\"]").text
    end

    # TODO: add dialy reports
    # def report_daily_totals
    #   report.find("[data-testid=\"report-daily-total\"] li")
    # end

    private

    def report
      browser.find("section[data-testid=\"report\"]")
    end
  end
end
