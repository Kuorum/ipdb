class FooController < ApplicationController

  def bar
    @city_text = params[:city_name]
  end

end