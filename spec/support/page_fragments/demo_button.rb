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

    def change_mode(new_mode)
      node
        .find("[data-testid|=mode]", text: new_mode)
        .click
    end

    def press
      node.find("[data-testid=button]").click
    end

    def status
      return "neutral" if node.find("[data-testid=button]")["class"].include?("btn-primary")
      return "active" if node.find("[data-testid=button]")["class"].include?("btn-danger")
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
