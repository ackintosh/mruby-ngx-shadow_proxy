class ShadowProxy
  def initialize(backend_host)
    @backend_host = backend_host
  end

  def on_backend_finished(&block)
    @callback = block
  end

  def run
    request = Nginx::Request.new

    headers = {}
    request.headers_in.all.keys.each do |k|
      headers[k] = request.headers_in[k]
    end

    http = HttpRequest.new()
    url = "#{request.scheme}://#{@backend_host}#{request.unparsed_uri}"
    res = http.request(request.method, url, nil, headers)

    @callback.call(res)
  end
end
