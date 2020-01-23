Rails.application.routes.draw do
 
  get '/login', to: 'welcome#login', as: 'loginPage'
  get '/', to: 'welcome#new', as: 'homePage'
  get '/projects', to: 'welcome#projects', as: 'projectPage'
  get '/register', to: 'welcome#new', as: 'registerPage'
  get '/about', to: 'welcome#new', as: 'aboutPage'
  post '/createAccount', to: 'welcome#createRecord', as: 'createUser'
   #reading project
   get '/openofflineproject', to: 'welcome#readProject', as: 'readOfflineProjectPage'
  post '/login', to: 'welcome#LoginProcess', as: 'loginProcess' 
  root 'welcome#new'

  #------------------------------------------------------------------------------------------#
  #------------------------------------------------------------------------------------------#
  #all route after login
  
  #get '/allproject', to: 'account#projects', as: 'allprojectPage'

  #menu - user DashBoard
  get '/dashboard', to: 'account#dashboard', as: 'userdashboardPage'
  
  #viewing all  or any projects after login - menu View Projects
  get '/allproject', to: 'account#allProject', as: 'allProjectPage'

  #loading and updating profile
  get '/profile', to: 'account#profile', as: 'profilePage'
  post '/updateprofile', to: 'account#Updateprofile', as: 'updateprofilePage'

  #editing project - loading and posting
  get '/prepEditproject', to: 'account#prepEditProject', as: 'prepEditproject'
  post '/editProject', to: 'account#editProject', as: 'editProject'

  #creating project - loading and posting
  get '/addproject', to: 'account#newProject', as: 'addprojectPage'
  post '/createProject', to: 'account#createProject', as: 'createProject'

  #reading project
  get '/openproject', to: 'account#readProject', as: 'readProjectPage'

  #delete project
  get '/prepDeleteproject', to: 'account#DeleteProject', as: 'prepDeleteproject'

  #add user to project
  get '/addUserproject', to: 'account#addUserproject', as: 'addUserproject'
  get '/selectUserproject', to: 'account#selectUserproject', as: 'selectUserproject'
  get '/deleteUserproject', to: 'account#deleteUserproject', as: 'deleteUserproject'
  get '/setUserprojectpermission', to: 'account#setPermission', as: 'setUserprojectpermission'
  get '/viewProjectUsers', to: 'account#viewProjectUsers', as: 'viewProjectUsers'
  post '/searchUserproject', to: 'account#searchUserproject', as: 'searchUserproject'
  post '/updateUserprojectPermission', to: 'account#updateUserPermission', as: 'updateUserprojectPermission'
 
  #dealing with threads
  get '/createThread', to: 'thread_process#createThread', as: 'createThread'
  get '/viewProjectThread', to: 'thread_process#viewProjectThread', as: 'viewProjectThread'
  get '/readProjectThread', to: 'thread_process#readProjectThread', as: 'readProjectThread'
  get '/deleteThreadMessage', to: 'thread_process#deleteThreadMessage', as: 'deleteThreadMessage' 
  get '/editThreadMessage', to: 'thread_process#editThreadMessage', as: 'editThreadMessage' 
  post '/saveThread', to: 'thread_process#saveThread', as: 'saveThread'
  post '/addThreadMessage', to: 'thread_process#saveThreadMessage', as: 'saveThreadMessage'
  post '/updateThreadMessage', to: 'thread_process#updateThreadMessage', as: 'updateThreadMessage'
  
  #dealing with project attachments
  get '/addAttachment', to: 'thread_process#addAttachment', as: 'addAttachment'
  post '/saveAttachment', to: 'thread_process#saveAttachment', as: 'saveAttachment'
  get '/removeAttachment', to: 'thread_process#removeAttachment', as: 'removeAttachment'

  #dealing with project task
  get '/addTask', to: 'thread_process#addTask', as: 'addTask'
  get '/viewAllTask', to: 'thread_process#viewAllTask', as: 'viewAllTask'
  get '/removeTask', to: 'thread_process#removeTask', as: 'removeTask'
  get '/editTask', to: 'thread_process#editTask', as: 'editTask'
  post '/saveTask', to: 'thread_process#saveTask', as: 'saveTask'
  post '/updateTask', to: 'thread_process#updateTask', as: 'updateTask'
  
  #admin only commands
  #view Users project
  get '/allusers', to: 'account#viewUsers', as: 'viewUsers'
  get '/setAdmin', to: 'account#setAdmin', as: 'setAdmin'
  get '/removeAdmin', to: 'account#removeAdmin', as: 'removeAdmin'
  
  #sign out or log out
  get '/signout', to: 'account#destroy', as: 'signoutPage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end