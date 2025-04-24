class CoveragesController < ApplicationController
  def show
    @coverage = Coverage.find(params[:id])
  end
end
