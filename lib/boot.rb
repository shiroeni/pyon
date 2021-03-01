# frozen_string_literal: true

require 'dotenv'
Dotenv.load

ENV['APP_ENV'] ||= 'development'

require 'bundler'
Bundler.require(:default, ENV['APP_ENV'])

require_relative 'application'
require_relative 'uploader'
require_relative 'callbacks'
