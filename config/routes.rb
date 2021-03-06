# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  get 'importer_documentation/guide'
  get 'importer_documentation/csv'

  post 'csv_imports/preview', as: 'preview_csv_import'
  get 'csv_imports/preview', to: redirect('csv_imports/new')
  resources :csv_imports, only: [:index, :show, :new, :create]

  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
  mount Blacklight::Engine => '/'

  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
