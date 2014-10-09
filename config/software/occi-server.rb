name "occi-server"
default_version "master"

dependency "ruby"
dependency "rubygems"
dependency "rsync"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

source git: "https://github.com/EGI-FCTF/rOCCI-server"

build do
  gem "install bundler -n #{install_dir}/embedded/bin --no-rdoc --no-ri"
  gem "install passenger -n #{install_dir}/embedded/bin --no-rdoc --no-ri"
  gem "install rake -v '~> 10.3.2' -n #{install_dir}/embedded/bin --no-rdoc --no-ri -f"
  bundle "install --deployment --without development test --path=#{install_dir}/embedded/app/vendor/bundle", :env => env
  command "mkdir -p #{install_dir}/embedded/app/rOCCI-server"
  command "#{install_dir}/embedded/bin/rsync -a --delete --exclude=.git/*** --exclude=.gitignore ./ #{install_dir}/embedded/app/rOCCI-server/"
  delete "#{install_dir}/embedded/app/rOCCI-server/vendor/bundle"
end
