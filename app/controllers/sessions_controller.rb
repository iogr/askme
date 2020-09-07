class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.authenticate(params[:email], params[:password])

    if @user.present?
      session[:user_id] = @user[:id]
      redirect_to root_path, notice: 'You are logged in'
    else
      flash.now.alert = 'Wrong email or password'
      render :new
    end
  end

  # Удаляет сессию залогиненного юзера
  def destroy
    # Затигаем в сесси значение ключа :user_id
    session[:user_id] = nil

    redirect_to root_path, notice: 'Вы разлогинились!'
  end
end
