Rails.application.routes.draw do

  # Dashboard routes
  get "home", to: "home#index"

  # Admins routes
  get "admin/new", to: "admins#new"
  # get     'admin/:username'     , to: 'admins#show'        , as: 'admin'
  post "admin/new", to: "admins#create"
  get "admin/:username/profile", to: "admins#edit", as: "edit_admin"
  put "admin/:username/profile", to: "admins#update"
  patch "admin/:username/profile", to: "admins#update"

  # Students routes
  get "admin/classrooms/:classroom_id/students/:student_id", to: "students#show", as: "student"
  get "signup", to: "students#new", as: "students_signup"
  post "signup", to: "students#create"
  get ":username/profile/", to: "students#edit", as: "edit_student"
  put ":username/profile/", to: "students#update"
  patch ":username/profile/", to: "students#update"
  patch "admin/classrooms/:classroom_id/students/:student_id/activate", to: "students#activate", as: "activate_student"
  patch "admin/classrooms/:classroom_id/students/:student_id/deactivate", to: "students#deactivate", as: "deactivate_student"
  delete "admin/classrooms/:classroom_id/students/:student_id/delete", to: "students#destroy", as: "destroy_student"

  #
  # For future implementation
  #

  # Reviewers routes
  # get     'admin/reviewers/:username'     , to: 'reviewers#show'       , as: 'reviewer'
  # get     'admin/reviewers'               , to: 'reviewers#index'      , as: 'reviewers'
  # get     'reviewers/signup'              , to: 'reviewers#new'
  # post    'reviewers/signup'              , to: 'reviewers#create'
  # get     'reviewers/:username/profile'    , to: 'reviewers#edit'       , as: 'reviewer_edit'
  # put     'reviewers/:username/profile/'      , to: 'reviewers#update'
  # patch   'reviewers/:username/profile/'      , to: 'reviewers#update'
  # patch   'reviewers/:id/activate/'       , to: 'reviewers#activate'   , as: 'activate_reviewer'
  # patch   'reviewers/:id/deactivate/'     , to: 'reviewers#deactivate' , as: 'deactivate_reviewer'
  # delete  'reviewers/:id/delete'          , to: 'reviewers#destroy'    , as: 'destroy_reviewer'

  # User Activation routes
  get "user_verification/:token/edit", to: "user_verifications#edit", as: "edit_user_verification"

  # Password Recovery routes
  get "password_reset", to: "password_resets#new", as: "password_reset"
  post "password_reset", to: "password_resets#create"
  get "password_reset/:token/edit", to: "password_resets#edit", as: "edit_password_reset"
  put "password_reset/:token/edit", to: "password_resets#update"
  patch "password_reset/:token/edit", to: "password_resets#update"

  # Sessions routes
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  get "logout", to: "sessions#leave"
  delete "logout", to: "sessions#destroy"

  # Addresses routes
  resources :addresses, path: "admin/addresses"

  # Schools routes
  resources :schools, path: "admin/schools"

  # Categories routes
  resources :categories, path: "admin/categories"

  # Themes routes
  resources :themes, path: "admin/themes"

  # Competences routes
  resources :competences, path: "admin/categories/:category/competences/", except: [:index, :destroy]

  # Comments routes
  resources :comments, path: "admin/categories/:category/competence/:competence/comments", except: [:index, :show, :destroy]

  # Classrooms routes
  resources :classrooms, path: "admin/classrooms", except: [:destroy]

  # Submissions (Essays + Corrections) routes
  get "submissions", to: "submissions#index", as: "submissions"

  # Essays routes
  get "essays", to: "essays#index", as: "essays"
  post "essays", to: "essays#create"
  get "essays/essay_file", to: "essays#download", as: "download_essay_model"
  get "essays/send/", to: "essays#new", as: "new_essay"
  get "essays/send/:theme_hash_id", to: "essays#submit", as: "submit_essay"
  delete "essays/:essay_hash_id", to: "essays#destroy", as: "destroy_essay"

  # Corrections routes
  get "corrections", to: "corrections#index", as: "corrections"
  get "corrections/new", to: "corrections#new", as: "new_correction"
  get "corrections/:correction_hash_id", to: "corrections#show", as: "show_correction"
  get "corrections/:essay_hash_id/validate", to: "corrections#validate", as: "validate_correction"
  post "corrections/:essay_hash_id/", to: "corrections#create", as: "create_correction"
  get "corrections/:correction_hash_id/start", to: "corrections#start", as: "start_correction"
  patch "corrections/:correction_hash_id/", to: "corrections#update", as: "update_correction"
  post "corrections/:correction_hash_id/finish", to: "corrections#finish", as: "finish_correction"

  # Correction Comments routes
  delete "corrections/:id/comment/delete", to: "correction_comments#destroy", as: "destroy_correction_comment"

  # Credits routes
  get ":user_id/credits/refill", to: "credits#edit", as: "edit_credits"
  patch ":user_id/credits/refill", to: "credits#update", as: "update_credits"

  # Root
  root "sessions#new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
