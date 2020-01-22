class ThreadProcessController < ApplicationController
    def createThread
        @users = User.find(session[:authid])
        @project = ProjectThread.new
       # @loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:view] !=nil
            @projectComments = ProjectUser.where(projectid: params[:view]).order(id: :desc)
            @project = Project.where(projectid: params[:view])
            render 'newThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end

    def saveThread
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil
            newthread = ProjectThread.new
            newthread.description = post_params[:description]
            newthread.project_id = params[:pid]
            newthread.save
            @project = Project.where(projectid: params['projectid'])
            flash.now[:error] = "Thread Created Successfully"
            render 'newThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def viewProjectThread
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params['view']
            @project = Project.where(projectid: params['view'])
            render 'projectThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def readProjectThread
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params['view']
            @project = ProjectThread.where(id: params['view'])
            render 'openThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    
    def saveThreadMessage
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil
            thMessage = ThreadMessage.new
            thMessage.project_thread_id = params[:threadid]
            thMessage.message = params[:description]
            thMessage.userid = session['authid']
            thMessage.save
            @project = ProjectThread.where(id: params[:threadid])
            render 'openThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end

    def deleteThreadMessage
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:threadid] !=nil and params[:view] !=nil
            @project = ProjectThread.where(id: params[:threadid])
            ThreadMessage.delete_by("id =:id and userid=:userid",{id:params[:view], userid:session[:authid]} )
            render 'openThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def editThreadMessage
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:threadid] !=nil and params[:view] !=nil
            @project = ProjectThread.where(id: params[:threadid])
            @thmsg = ThreadMessage.find_by("id=:id and userid=:userid",{id:params[:view], userid:session[:authid]} )
            render 'editThreadMessage'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def updateThreadMessage
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:messageid] !=nil
            @project = ProjectThread.where(id: params[:threadid])
            thmsg = ThreadMessage.find_by("id=:id and userid=:userid",{id:params[:messageid], userid:session[:authid]} )
            thmsg.message = params[:description]
            thmsg.save
            render 'openThread'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def addAttachment
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:view] !=nil
            @project = Project.where(projectid: params[:view])
            render 'addAttachment'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end

    def saveAttachment
        @users = User.find(session[:authid])
        #@loggedin = User.where("login = :login", { login: "1"})
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil
            @project = Project.where(id: params[:projectid])
            newAttach = ProjectAttached.new
            newAttach.userid = @users.userid
            newAttach.project_id = @project[0].id
            newAttach.comment =params[:description]
            if params[:images]
                newAttach.images.attach(params[:images])
            end
            newAttach.save
            flash.now[:error] ="Attachment Created !"
            render 'addAttachment'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def removeAttachment
        if session[:authid] != nil and params[:view] !=nil
            @image = ActiveStorage::Attachment.find(params[:view])
            @image.purge
            redirect_to :controller => 'account', :action => 'readProject', view: params[:projectid]

        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    private def post_params
        params.require(:ProjectThread).permit(:description, :projectid, :pid)
    end

    private def attachParams
        params.require(:ProjectAttached).permit(:description, :projectid, :userid,:images[])
    end
end
