class UsersController < ApplicationController
  before_action :load_user, except: [:index, :create, :new]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    # Создаём массив из двух болванок пользователей. Вызываем метод # User.new, который создает модель, не записывая её в базу.
    # У каждого юзера мы прописали id, чтобы сымитировать реальную
    # # ситуацию – иначе не будет работать хелпер путей

    # @users = [
    #   User.new(
    #     id: 1,
    #     name: 'Vadim',
    #     username: 'installero',
    #     avatar_url: 'https://secure.gravatar.com/avatar/' \
    #     '71269686e0f757ddb4f73614f43ae445?s=100'
    #   ),
    #   User.new(id: 2, name: 'Misha', username: 'aristofun'),
    #   User.new(id: 3, name: 'Missha', username: 'aristo00fun', avatar_url: 'avatar2.jpg')
    # ]
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?
    @user = User.new(user_params)

    if @user.save
      #ЗАПОМНИТЬ ПОСЛЕДОВАТЕЛЬНОСТЬ
      session[:user_id] = @user[:id]
      redirect_to root_path, notice: 'Ok'
    else
      render :new
    end
  end

  def edit
    # @user = User.find params[:id]
  end

  def update
    # @user = User.find params[:id]

    if @user.update(user_params)
      redirect_to user_path, notice: "Form is updated"
    else
      render 'edit'
    end
  end

  def show
    # @questions = @user.questions.order(created_at: :desc)

    # @new_question = @user.questions.build
    # @user = User.find params[:id]
    # берём вопросы у найденного юзера
    @questions = @user.questions.order(created_at: :desc)
    #todo
    # @questions = @user.questions.sorted_desc
    @questions_count = @questions.count
    @answers_count = @questions.with_answers.count
    @unanswered_count = @questions_count - @answers_count

    # Для формы нового вопроса создаём заготовку, вызывая build у результата вызова метода @user.questions.
    @new_question = @user.questions.build
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url)
  end
end
