class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  NUTCH_HOME = "/root/crawl/local/"
  INDEX_MASTER = "http://127.0.0.1:9200"
end
