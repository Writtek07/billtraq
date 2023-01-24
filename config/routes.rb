Rails.application.routes.draw do
  
  resources :students do
    collection { post :import}
    get :removed, on: :collection

    collection do
      get 'pending_fee'
      get 'missing'
    end

    resources :invoices
  end
 

  devise_for :users, controllers: {
        registrations: 'user/registrations'
      }


  
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

  root 'invoices#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
