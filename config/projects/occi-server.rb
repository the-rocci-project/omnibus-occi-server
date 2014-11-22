name "occi-server"
maintainer "parak@cesnet.cz"
homepage "https://github.com/EGI-FCTF/rOCCI-server"

# Defaults to C:/occi-server on Windows
# and /opt/occi-server on all other platforms
install_dir "#{default_root}/#{name}"
build_version "1.1.5"
build_iteration 3

override :rubygems, :version => '2.4.4'
override :ruby, :version => '2.1.5'

# Creates required build directories
dependency "preparation"

# occi-server dependencies/components
dependency "occi-server"

# Version manifest file
dependency "version-manifest"

# add external (runtime) dependencies/services
external_deps = if File.exists?('/etc/redhat-release')
                  # we are on CentOS/SL
                  %w(httpd mod_ssl policycoreutils-python mod_security memcached git mod_passenger rubygem-passenger-devel)
                else
                  # we are in Debian/Ubuntu
                  %w(apache2 libapache2-mod-passenger libapache2-modsecurity memcached git)
                end
external_deps.each { |ext_dep| runtime_dependency ext_dep }

exclude "**/.git"
exclude "**/bundler/git"
