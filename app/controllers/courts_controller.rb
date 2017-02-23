class CourtsController < ApplicationController
  def index
    @courts = Court.all
  end
end