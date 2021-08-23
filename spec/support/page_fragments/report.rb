module PageFragments
  module Report
    def report_totals
      report.find("[data-testid=\"report-total\"]").text
    end

    # TODO: add dialy reports
    def report_daily_totals
      report.all("[data-testid=\"report-daily-total\"] li").map(&:text)
    end

    private

    def report
      page.find("section[data-testid=\"report\"]")
    end
  end
end
