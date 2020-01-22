class AccountController < ApplicationController
    
    def dashboard
        if session[:authid] != nil
            #this action will load the currently login Home Page - route : userdashboardPage
            @users = User.find(session[:authid])
            @loggedin = User.where("login = :login", { login: "1"})
            #p @loggedin.authorname
            #lets paginate
            #totRecord = Project.count
            totRecord = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).count
            recPerPage = 4
            @noOfPage = totRecord % recPerPage == 0 ? (totRecord / recPerPage) : (totRecord / recPerPage) + 1
            
            #get every_page for offset record
            @current_page = params[:page] ? params[:page].to_i : 1

            #calculate for offset record
            recOffset = (@current_page - 1) * recPerPage

            #check for next and previous
            @hasPrev = @current_page > 1 ? true : false
            @hasNext = @current_page < @noOfPage ? true : false
            
            #retrieve only your live post for dashboard
            #@allMyPostDash = Project.where(userid:session[:authid]).limit(recPerPage).offset(recOffset).order(id: :desc)
            @allMyPostDash = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(recPerPage).offset(recOffset).order(id: :desc)
            @otherPost = ProjectUser.where(userid: session[:authid]).limit(recPerPage).order(id: :desc)
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end

    def allProject
        #when a user try to view all projects after login - [view Projects]
        if session[:authid] != nil
            @users = User.find(session[:authid])
            @loggedin = User.where("login = :login", { login: "1"})
            #lets paginate
            #get all status not yet deleted
            totRecord = ProjectUser.where(userid: session[:authid]).count
            recPerPage = 5
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
            @allotherPostDash = ProjectUser.where("userid = :userid", {userid: session[:authid]}).limit(recPerPage).offset(recOffset).order(id: :desc)
            #some of your project for left nav
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(recPerPage).order(id: :desc)
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end

    #profile loading and updating / adding profile pictures / images - active storage
    def profile
        #dis load the page
        if session[:authid] != nil
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(3).order(id: :desc)
            @users = User.find(session[:authid])
            @loggedin = User.where("login = :login", { login: "1"})
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end 
    end
    def Updateprofile
        if session[:authid] != nil
            @users = User.find(session[:authid])
            # @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(3).order(id: :desc)
            # @loggedin = User.where("login = :login", { login: "1"})
            if @users
                @users.email = post_user_params[:email]
                #@users.update_attribute(:email, post_user_params[:email])
                @users.phone = post_user_params[:phone]
                #@users.update_attribute(:phone, post_user_params[:phone])
                @users.contactAdd = post_user_params[:contactAdd]
                #@users.update_attribute(:contactAdd, post_user_params[:contactAdd])
                if post_user_params[:passport]
                    @users.passport.attach(post_user_params[:passport])
                end
                
                if @users.save()
                    flash.now[:error] ="Account Successfuly Updated !!! "
                    redirect_to profilePage_path
                    #render 'profile'
                else
                    flash.now[:error] ="Error: Unable To Update Record.. Retry"
                    redirect_to profilePage_path
                    #render 'profile'
                end 
            else
                flash.now[:error] ="Error: Unable To Update Record.. Retry"
                redirect_to profilePage_path
            end
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end


    #creating and saving new project
    #load Page
    def newProject
        if session[:authid] != nil
            @loggedin = User.where("login = :login", { login: "1"})
            @users = User.find(session[:authid])
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
            @project = Project.new
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end
    #save Page
    def createProject
        if session[:authid] != nil
            title = post_params[:title]
            description = post_params[:description]
            @project = Project.new
            projectid = "PRO".concat(rand(1000000000...9000000000).to_s)
            @project = Project.new(title:title,description:description, projectid:projectid,userid:session[:authid],status:"0")
            if @project.save
                flash[:error] ="New Post Created Succesfully !!"
                redirect_to addprojectPage_path
            else
                flash[:error] ="Sever Error Please Rety !!"
                redirect_to addprojectPage_path
            end
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end
    
    #editing an existing project
    #load the project
    def prepEditProject
        if session[:authid] != nil
            @loggedin = User.where("login = :login", { login: "1"})
            @users = User.find(session[:authid])
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
            if params[:view]
                @project = Project.find_by(projectid: params[:view], status: "0")
                if @project
                    render 'editProject'
                else
                    redirect_to userdashboardPage_path
                end
            else
                redirect_to userdashboardPage_path
            end
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end
    #submit the edited record
    def editProject
        if session[:authid] != nil
            @project = Project.find_by(projectid: post_params[:projectid], status: "0")
            if @project
                #@prova = @project.first.attributes
                @project.title = post_params[:title]
                @project.description = post_params[:description]

                if @project.save
                    flash[:error] ="Project Successfuly Updated !!! "
                    redirect_to :controller=>'account', :action => 'prepEditProject', view: post_params[:projectid]
                else
                    flash[:error] ="Error: Unable To Update Project.. Retry"
                    redirect_to :controller=>'account', :action => 'prepEditProject', view: post_params[:projectid]
                end
            else
                redirect_to userdashboardPage_path
            end
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end

    #reading / viewing a project
    def readProject
        if session[:authid] != nil
            @users = User.find(session[:authid])
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
            #@loggedin = User.where("login = :login", { login: "1"})
            if params[:view]
                @project = Project.find_by(projectid: params[:view], status: "0")
                @author = User.find_by_userid(@project['userid'])
                #if !@project.empty?
                if @project
                    @projectAttach = ProjectAttached.where(project_id: @project.id)
                    render 'readProject'
                else
                    redirect_to userdashboardPage_path
                end
            else
                redirect_to userdashboardPage_path
            end
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end
    
    def DeleteProject
        #delete / remove a project
        if session[:authid] != nil
            @users = User.find(session[:authid])
            if params[:view] && @users
                @project = Project.find_by(projectid: params[:view], status: "0")
                @project.update_attribute(:status, "1")
                if @project
                    redirect_to userdashboardPage_path
                else
                    redirect_to userdashboardPage_path
                end
            else
                redirect_to userdashboardPage_path
            end
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end

    #logging out part
    def destroy
        if session[:authid] != nil
            #show the user is out update login
            @users = User.find(session[:authid])
            @users.update_attribute(:login, "0")
            session[:authid] = nil
            reset_session
            redirect_to homePage_path
        else
            flash[:error] ="You have to Login To Access Resource !"
            redirect_to loginPage_path
        end
    end
    
    def viewUsers
        if session[:authid] != nil and session[:authright] =="1"
            #this action will load the currently login Home Page - route : userdashboardPage
            @users = User.find(session[:authid])
            @loggedin = User.where("login = :login", { login: "1"})
            #p @loggedin.authorname
            #lets paginate
            #totRecord = Project.count
            totRecord = User.count
            recPerPage = 10
            @noOfPage = totRecord % recPerPage == 0 ? (totRecord / recPerPage) : (totRecord / recPerPage) + 1
            
            #get every_page for offset record
            @current_page = params[:page] ? params[:page].to_i : 1

            #calculate for offset record
            recOffset = (@current_page - 1) * recPerPage

            #check for next and previous
            @hasPrev = @current_page > 1 ? true : false
            @hasNext = @current_page < @noOfPage ? true : false
            
            #retrieve only your live post for dashboard
            #@allMyPostDash = Project.where(userid:session[:authid]).limit(recPerPage).offset(recOffset).order(id: :desc)
            @allUsers = User.all.limit(recPerPage).offset(recOffset).order(id: :desc)
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
            render 'allUsers'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end

    def setAdmin
        if session[:authid] != nil and session[:authright] =="1"
            if params[:view]
                @users = User.find(params[:view])
                if  @users
                    @users.update_attribute(:right, "1")
                end
            end
            redirect_to viewUsers_path
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def removeAdmin
        if session[:authid] != nil and session[:authright] =="1"
            if params[:view]
                @users = User.find(params[:view])
                if  @users
                    @users.update_attribute(:right, "0")
                end
            end
            redirect_to viewUsers_path
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end

    #start of adding or manipulating project users
        def addUserproject
            @users = User.find(session[:authid])
            #@loggedin = User.where("login = :login", { login: "1"})
            if session[:authid] != nil and params[:proj] !=nil
                session['projectid'] = params[:proj]
                @project = Project.where(projectid: params[:proj])
                @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
                @projectUsers = ProjectUser.where(projectid: params[:proj]).order(id: :desc)
                render 'addUserproject'
            else
                flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
                redirect_to loginPage_path
            end
        end
  
        def searchUserproject
            @users = User.find(session[:authid])
           # @loggedin = User.where("login = :login", { login: "1"})
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
            if session[:authid] != nil and params[:searchValue] !=nil
                @project = Project.where(projectid: session['projectid'])
                @projectUsers = ProjectUser.where(projectid: session['projectid']).order(id: :desc)
                @searchResult = User.where("authorname like :authorname or email like :email ", {authorname: "%#{params[:searchValue]}%", email: "%#{params[:searchValue]}%"})
                #session['searchResult'] = @searchResult
                render 'addUserproject'
            else
                flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
                redirect_to loginPage_path
            end
        end
        def selectUserproject
            if session[:authid] != nil and params[:view] !=nil
                if ProjectUser.where("projectid = :projectid and userid = :userid", { projectid: session[:projectid], userid: params[:view] }).count < 1
                    projUser = ProjectUser.new
                    projUser.projectid = session['projectid']
                    projUser.userid = params[:view]
                    projUser.save
                end
                redirect_to :controller=>'account', :action => 'addUserproject', proj: session['projectid']
            else
                flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
                redirect_to loginPage_path
            end
        end

        def deleteUserproject
            if session[:authid] != nil and params[:view] !=nil
                ProjectUser.delete_by(projectid: session[:projectid], userid: params[:view])
                @projectUsers = ProjectUser.where(projectid: session['projectid']).order(id: :desc)
                redirect_to :controller=>'account', :action => 'addUserproject', proj: session['projectid']
            else
                flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
                redirect_to loginPage_path
            end
        end

        def setPermission
            @users = User.find(session[:authid])
            #@loggedin = User.where("login = :login", { login: "1"})
            @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
            if session[:authid] != nil and session['projectid'] !=nil
                @projectUsers = ProjectUser.where(projectid: session['projectid']).order(id: :desc)
                @project = Project.where(projectid: session['projectid'])
                render 'setPermission'
            else
                flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
                redirect_to loginPage_path
            end
        end
        def updateUserPermission
            if session[:authid] != nil and session['projectid'] !=nil
                all = params[:all]
                if  all.length > 0
                    all.each do |userid|
                        userNow = ProjectUser.find_by("projectid = :projectid and userid = :userid", { projectid: session[:projectid], userid: userid })
                        if params[:read] !=nil and (params[:read].include? userid) then userNow.rea=true else userNow.rea=false end
                        if params[:write] !=nil and (params[:write].include? userid) then userNow.wri=true else userNow.wri=false end
                        if params[:edit] !=nil and (params[:edit].include? userid) then userNow.edi=true else userNow.edi=false end
                        if params[:del] !=nil and (params[:del].include? userid) then userNow.del=true else userNow.del=false end
                        userNow.save
                    end
                end
                flash[:error] ="Users Permission Succesfully Updated !"
                redirect_to setUserprojectpermission_path
            else
                flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
                redirect_to loginPage_path
            end
        end    
    #added user wants to view project users
    def viewProjectUsers
        @users = User.find(session[:authid])
        @loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:proj] !=nil
            @projectUsers = ProjectUser.where(projectid: params[:proj]).order(id: :desc)
            @project = Project.where(projectid: params[:proj])
            render 'viewAllProjectUser'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
#end of adding or viewing or updating project users
    

    private def post_params
        params.require(:project).permit(:title, :description, :projectid)
    end

    private def post_user_params
        params.require(:users).permit(:passport, :email, :phone,:contactAdd)
    end
end