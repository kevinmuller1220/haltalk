class RelsController < ApplicationController
  def show
    render params[:rel]
  end
end
