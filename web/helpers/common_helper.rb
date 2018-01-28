module Helpers
  module CommonHelper
    def unprocessable!
      error!(status: 422)
    end

    def unauthorized!
      error!(status: 403)
    end

    def not_found!
      error!(status: 404)
    end

    def redirect_to(path)
      res.redirect(path)

      halt(res.finish)
    end

    def error!(status:)
      res.status = status

      halt(res.finish)
    end

    def send_as_file(filename, content)
      res.headers['Content-Description'] = 'File Transfer'
      res.headers['Content-Type'] = 'application/octet-stream'
      res.headers['Content-Disposition'] = 'attachment; filename="' + filename + '"'
      res.headers['Expires'] = '0'
      res.headers['Cache-Control'] = 'must-revalidate'
      res.headers['Pragma'] = 'public'
      res.headers['Content-Length'] = content.size

      res.status = 200
      res.write(content)
      halt(res.finish)
    end

  end
end
