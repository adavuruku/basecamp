class WelcomeController < ApplicationController
  

  #process the login
  def login
    @allotherPostDash = Project.where("status = :status", { status: "0"}).limit(6).order(id: :desc)
    render 'login'
  end
  def LoginProcess
    @email = params[:email];
    @allotherPostDash = Project.where("status = :status", { status: "0"}).limit(6).order(id: :desc)
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:authid] =  @user.userid
      session[:authname] =  @user.authorname
      session[:authemail] =  @user.email
      session[:authright] =  @user.right
      @user.update_attribute(:login, "1")
      redirect_to userdashboardPage_path
    else
      flash.now[:error] ="Invalid Email Or Password Verify"
      render 'login'
    end
  end

  #creating or adding new user
  def new
    @allotherPostDash = Project.where("status = :status", { status: "0"}).limit(6).order(id: :desc)
    @user = User.new
    @error = "";
    render 'index'
  end
  def createRecord
    authorname = post_params[:authorname]
    email = post_params[:email]
    phone = post_params[:phone]
    password = post_params[:password]
    repassword = post_params[:password_confirmation]
    contactAdd = post_params[:contactAdd]
    @user = User.new
    @user.contactAdd = contactAdd
    @user.phone = phone
    @user.email = email
    @user.authorname = authorname
    if password == repassword
        userID = rand(10000000...90000000)
        right = "0"
        login="1"
        @user = User.new(authorname:authorname,email:email, phone:phone,password:password,
          contactAdd:contactAdd, userid:userID.to_s, login:login, right:right)
          if @user.save
            session[:authid] =  @user.userid
            @user.update_attribute(:login, "1")
            redirect_to userdashboardPage_path
          else
            flash.now[:error] ="Sever Error Please Rety !!"
            render 'index'
          end
    else
      flash.now[:error] = "Choosen Password / Confirm Password Are Not Thesame - Verify ";
      render 'index'     
    end
  end

  #reading / viewing a project from outside
  def readProject
      @allMyPost = Project.where("status = :status", { status: "0"}).limit(6).order(id: :desc)
      if params[:view]
          @project = Project.find_by(projectid: params[:view], status: "0")
          @uthor = User.find_by_userid(@project['userid'])
          #if !@project.empty?
          if @project
              render 'readProjectOffline'
          else
              redirect_to homePage_path
          end
      else
          redirect_to homePage_path
      end
  end

  def projects
    #lets paginate
    #get all status not yet deleted
    totRecord = Project.where(status: "0").count
    recPerPage = 6
    @noOfPage = totRecord % recPerPage == 0 ? (totRecord / recPerPage) : (totRecord / recPerPage) + 1
    
    #get every_page for offset record
    @current_page = params[:page] ? params[:page].to_i : 1

    #calculate for offset record
    recOffset = (@current_page - 1) * recPerPage

    #check for next and previous
    @hasPrev = @current_page > 1 ? true : false
    @hasNext = @current_page < @noOfPage ? true : false
    
    #retrieve the record - of other peoples post apart yours
    #@allMyPostDash = Project.where(status: "0").limit(recPerPage).offset(recOffset).order(id: :desc)
    @allotherPostDash = Project.where("status = :status", { status: "0"}).limit(recPerPage).offset(recOffset).order(id: :desc)
    render 'allProjectOffline'
  end

  private def post_params
    params.require(:user).permit(:authorname, :email, :phone, :password, :password_confirmation, :contactAdd)
  end
end
