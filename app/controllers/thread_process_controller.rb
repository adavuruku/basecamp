class ThreadProcessController < ApplicationController
    def createThread
        @users = User.find(session[:authid])
        @project = ProjectThread.new
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
        newthread = ProjectThread.new
        newthread.description = post_params[:description]
        newthread.project_id = params[:pid]
        newthread.save
        flash[:error] = "Thread Created Successfully"
        redirect_to :controller=>'thread_process', :action => 'createThread', view: params['projectid']
    end
    def viewProjectThread
        @users = User.find(session[:authid])
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
        thMessage = ThreadMessage.new
        thMessage.project_thread_id = params[:threadid]
        thMessage.message = params[:description]
        thMessage.userid = session['authid']
        thMessage.save
        redirect_to :controller=>'thread_process', :action => 'readProjectThread', view: params[:threadid]
    end

    def deleteThreadMessage
        if session[:authid] != nil and params[:threadid] !=nil and params[:view] !=nil
            ThreadMessage.delete_by("id =:id and userid=:userid",{id:params[:view], userid:session[:authid]} )
            redirect_to :controller=>'thread_process', :action => 'readProjectThread', view: params[:threadid]
        else
            flash[:error] ="You have No Access Requested Resource !"
            redirect_to loginPage_path
        end
    end
    def editThreadMessage
        @users = User.find(session[:authid])
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:threadid] !=nil and params[:view] !=nil
            @project = ProjectThread.where(id: params[:threadid])
            @thmsg = ThreadMessage.find_by("id=:id and userid=:userid",{id:params[:view], userid:session[:authid]} )
            render 'editThreadMessage'
        else
            flash[:error] ="You have No Access Requested Resource !"
            redirect_to loginPage_path
        end
    end
    def updateThreadMessage
        if session[:authid] != nil and params[:messageid] !=nil
            thmsg = ThreadMessage.find_by("id=:id and userid=:userid",{id:params[:messageid], userid:session[:authid]} )
            thmsg.message = params[:description]
            thmsg.save
            redirect_to :controller=>'thread_process', :action => 'readProjectThread', view: params[:threadid]
        else
            flash[:error] ="You have No Access Requested Resource !"
            redirect_to loginPage_path
        end
    end
    def addAttachment
        @users = User.find(session[:authid])
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params[:view] !=nil
            @project = Project.where(projectid: params[:view])
            @projectAttach = ProjectAttached.where(project_id: @project[0].id)
            render 'addAttachment'
        else
            flash[:error] ="You have No Access Requested Resource !"
            redirect_to loginPage_path
        end
    end

    def saveAttachment
        @project = Project.where(id: params[:projectid])
        newAttach = ProjectAttached.new
        newAttach.userid = session[:authid]
        newAttach.project_id = @project[0].id
        newAttach.comment =params[:description]
        if params[:images]
            newAttach.images.attach(params[:images])
        end
        newAttach.save
        flash[:error] ="Attachment Created !"
        #render 'addAttachment'
        redirect_to :controller=>'thread_process', :action => 'addAttachment', view: params[:projectidTag] 
    end
    def removeAttachment
        if session[:authid] != nil and params[:view] !=nil
            @image = ActiveStorage::Attachment.find(params[:view])
            puts ActiveStorage::Attachment.count
            @image.purge
            puts ActiveStorage::Attachment.count
            redirect_to :controller => 'thread_process', :action => 'addAttachment', view: params[:projectid]
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def addTask
        @users = User.find(session[:authid])
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params['view']
            @project = Project.where(projectid: params['view'])
            newTask = ProjectTask.new
            render 'newTask'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def saveTask
        newTask = ProjectTask.new
        newTask.description = task_params[:description]
        newTask.project_id = params[:pid]
        newTask.userid = session[:authid]
        newTask.save
        flash[:error] = "Task Created Successfully"
        redirect_to :controller=>'thread_process', :action => 'addTask', view: params['projectid']
    end
    def viewAllTask
        @users = User.find(session[:authid])
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params['view']
            @project = Project.where(projectid: params['view'])
            render 'projectTask'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end  
    end
    def removeTask
        if session[:authid] != nil and params['view'] !=nil
            ProjectTask.delete_by(id:params[:view])
            redirect_to :controller=>'thread_process', :action => 'addTask', view: params['projectid']
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def editTask
        @users = User.find(session[:authid])
        @allMyPost = Project.where("status = :status and userid = :userid", { status: "0", userid: session[:authid] }).limit(5).order(id: :desc)
        if session[:authid] != nil and params['view']
            @project = ProjectTask.where(id: params['view'])
            render 'editTask'
        else
            flash[:error] ="You have to Login To Admin DashBoard to Access Resource !"
            redirect_to loginPage_path
        end
    end
    def updateTask
        dek = ProjectTask.find_by(id:params[:taskid])
        dek.description = params[:description]
        dek.save
        redirect_to :controller=>'thread_process', :action => 'addTask', view: params['projectid']
    end
    private def post_params
        params.require(:ProjectThread).permit(:description, :projectid, :pid)
    end
    private def task_params
        params.require(:ProjectTask).permit(:description, :projectid, :pid)
    end
    private def attachParams
        params.require(:ProjectAttached).permit(:description, :projectid, :userid,:images[])
    end
end
