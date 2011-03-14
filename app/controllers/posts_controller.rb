class PostsController < ApplicationController
include SessionsHelper

#today before_filter :authenticate, :except => [:index, :show]
before_filter :correct_user, :only => [:edit, :update]
  # GET /posts
  # GET /posts.xml
  def index
     
	i=0
	@postname = {}
	@post = {}
	@user = {}
     for post in Post.find(:all, :include => [ :user ])   
	   i += 1	
   	   @postname[i] = post.user.name
	   @post[i] = post
	   @user [i] = User.find(@post[i].user_id)
     end
    @post_keys = @post.keys.paginate :page => params[:page], :per_page => 	4

    @postname_keys = @postname.keys.paginate :page => params[:page], :per_page => 	4


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new
    @user = current_user 
    @post.user_id = @user.id

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit

    @user = current_user 
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @user = current_user 
    @post.user_id = @user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
