class AuthorsController < ApplicationController
  def index
    @filterrific = initialize_filterrific(
      Author,
      params[:filterrific],
      select_options: {}
    ) or return

    @pagy, @authors = pagy(@filterrific.find.order(:name))
  end
end