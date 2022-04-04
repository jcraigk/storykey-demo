# frozen_string_literal: true
Rails.application.routes.draw do
  root 'dashboard#index'
  post '/', to: 'dashboard#index', as: :index
end
