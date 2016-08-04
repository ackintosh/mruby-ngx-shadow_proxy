# HTTP shadow proxy logic written in ngx_mruby.

## install by mrbgems
 - add conf.gem line to `build_config.rb`
```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'ackintosh/ngx_mruby-shadow_proxy'
end
```

## example

```ruby
# nginx.conf
# mruby_log_handler /path/to/shadow_proxy.rb;

sp = ShadowProxy.new("example.com")

sp.on_backend_finished do |res|
  if res.code == 500
    Nginx.errlogger Nginx::LOG_ERR, "error!"
  end

  Nginx.errlogger Nginx::LOG_ERR, res.code
end

sp.run
```

# License
under the MIT License:

* http://www.opensource.org/licenses/mit-license.php

