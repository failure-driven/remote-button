class QuotesController < ApplicationController
  def sample
    render(json: QUOTES.sample)
  end
end
