# frozen_string_literal: true
require 'irb'
class Application < Sinatra::Base
  set :sessions, true
  set :exceptions, ENV['APP_ENV'] == 'development'
  set :views, File.join(Dir.pwd, 'views')

  # File uploader
  # Generic web-interface
  get '/' do
    slim :index
  end

  post '/upload' do
    @result = uploader.upload_all(params[:files])

    if request.accept?('text/html')
      slim :upload
    else
      {
        success: true,
        files: @result.map do |info|
          {
            url: "https://#{ENV['APP_HOST']}/#{info[:new_name]}",
            size: info[:size],
            name: info[:original_name]
          }
        end
      }.to_json
    end
  ensure
    callbacks.run(request, @result)
  end

  private

  def uploader
    @uploader ||= Uploader.new
  end

  def callbacks
    @callbacks ||= Callbacks.new
  end
end
