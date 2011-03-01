class UsersController < ApplicationController
    
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :correct_user, :only => [:edit, :update]

  protect_from_forgery
  include SessionsHelper

  # GET /users
  # GET /users.xml
  def index
    @users = User.all
    @users = User.paginate :page => params[:page], :per_page => 	3
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
  	   sign_in @user
        format.html { 
        flash[:success] = "Welcome to the Sample App!"
        redirect_to @user}
        format.xml  { render :xml => @user, :status => 		  	   :created, :location => @user }
      else
	   @title = "Sign up"
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => 	  :unprocessable_entity }
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    @title = "Edit user"
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

end


