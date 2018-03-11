require './web/server'
require './api/server'

Cuba.define do
  on('api') { run API::Server }

  run Web::Server
end
