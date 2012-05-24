class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :following, :followers]
  before_filter :admin_user, only: :destroy
  before_filter :entrado_quiere_entrar, only: [:new, :create]
  
  def new
      @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Ya sos usuario!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Tenes algo diferente!"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def index
    @users = User.paginate(page: params[:page])
    #@users.sort!
  end
  
  def following
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Listo, se fue"
    redirect_to users_path
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:error] = "No podes hacer eso!"
        redirect_to(root_path)
      end
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def entrado_quiere_entrar
      if signed_in?
        redirect_to root_path, notice: "Pero ya estas loggeado!"     
      end
    end
    
end
