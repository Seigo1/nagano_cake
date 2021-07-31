Rails.application.routes.draw do
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only:[:index, :show]
    resources :registrations, only:[:new, :create]
    resources :sessions, only:[:new, :create, :destroy]
    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/unsubscribe' => 'customers#destroy'
    resources :customers, only:[:show, :edit, :update]
    delete 'cart_items' => 'cart_items#alldestroy'
    resources :cart_items, only:[:index, :update, :destroy, :create]
    post 'orders/confirm' => 'orders#confirm', as: :confirm
    get 'orders/thanks' => 'orders#thanks'
    resources :orders, only:[:new, :create, :index, :show]
    resources :addresses, only:[:index, :edit, :create, :update]
    delete 'addresses/:id/edit' => 'addresses#destroy'
  end
  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only:[:index, :new, :create, :show, :edit, :update]
    resources :genres, only:[:index, :create, :edit, :update]
    resources :customers, only:[:index, :show, :edit, :update]
    patch 'orders/:id/edit' => 'admin/orders#orderstatus'
    patch 'orders/:id/edit' => 'admin/orders#productstatus'
    resources :orders, only:[:edit]
  end
end
