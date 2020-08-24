class UsersController < ApplicationController
  def show
    @time = Time.now
    @hello = "Привет, Антон!"
  end
end

