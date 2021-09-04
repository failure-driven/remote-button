module PageFragments
  module DemoButton
    def modes
      node.all("[data-testid|=mode]").map(&:text)
    end

    def mode
      node
        .all("[data-testid|=mode]")
        .find { |mode| mode["class"].include?("active") }
      &.text
    end

    def press
      node.find("button").click
    end

    def status
      return "neutral" if node.find("button")["class"].include?("btn-primary")
      return "active" if node.find("button")["class"].include?("btn-danger")
    end

    def message
      node.find("[data-testid=message]").text
    end

    private

    def node
      page.find("[data-testid=demo-button]")
    end
  end
end