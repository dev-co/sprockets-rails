class OmgController < ApplicationController
  def index
    flash[:cool_story] = true
    render :text => "ok"
  end
end