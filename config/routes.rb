Rails.application.routes.draw do
  
  get 'fee_reminder/index'
  post 'fee_reminder/index'
  
  resources :students do
    collection { post :import}
    
    collection do
      get 'pending_fee'
      post 'pending_fee', to: 'students#send_fee_reminder', as: 'send_fee_reminder_path'
      get 'missing'
      get 'removed'
    end

    member do
      patch :undiscard      
    end
    resources :invoices
  end
 
  

  devise_for :users, controllers: {
        registrations: 'user/registrations'
      }

  #/student/:id/update_

  
  get 'invoices/print/:id', to: 'invoices#print', as: 'invoices_print'


  #get 'invoices#cheque', to: 'invoices#cheque', as: 'invoice_cheque'

  #get 'students#missing', to: 'students#missing', as: 'students_missing'


  get 'invoices/show/:id', to: 'students#show_invoices', as: 'students_show_invoices'

  resources :invoices do
      collection do
        match 'search' => 'invoices#search', via: [:get, :post], as: :search

        get 'cheque'

      end

      resources :particulars, except: [:show], controller: 'invoices/particulars'
  end

  namespace :admin do
    resources :dashboard
  end

  root 'invoices#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
