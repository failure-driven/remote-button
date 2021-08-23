module PageFragments
  module DemoSection
    def title
      node.find("[data-testid=title]").text
    end

    def footer
      node.find("[data-testid=footer]").text
    end

    private

    def node
      page.find("section[data-testid=demo-section]")
    end
  end
end
