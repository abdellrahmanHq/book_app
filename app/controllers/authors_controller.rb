class AuthorsController < ApplicationController
  before_action :authenticate_author!
  def index
    @pagy,@authors=pagy(Author.order(:name))
  end
end
