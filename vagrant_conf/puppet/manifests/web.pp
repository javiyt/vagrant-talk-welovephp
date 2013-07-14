class web
{
	notify{"class_web": message => "class web"}

	$webPackages = ["nginx"]
	package {
		$webPackages:
			ensure => latest,
			require => Exec['apt-get update']
	}

	service {
		'nginx':
			ensure => running,
			require => Package['nginx'],
	}

	service {
		'mongodb':
			ensure => running,
			require => Package['mongodb-10gen'],
	}

	file {
		"/etc/nginx/nginx.conf":
			notify => Service["nginx"],
			mode => 664,
			owner => root,
			group => root,
			require => Package["nginx"],
			source => "/vagrant/vagrant_conf/puppet/conf/etc/nginx/nginx.conf",
	}

	file {
		"/etc/nginx/fastcgi_params":
			notify => Service["nginx"],
			mode => 644,
			owner => root,
			group => root,
			require => Package["nginx"],
			source => "/vagrant/vagrant_conf/puppet/conf/etc/nginx/fastcgi_params"
	}

	file {
		"/etc/nginx/sites-available/default":
			notify => Service["nginx"],
			mode => 664,
			owner => root,
			group => root,
			require => Package["nginx"],
			source => "/vagrant/vagrant_conf/puppet/conf/etc/nginx/sites/workshop.vhost"
	}
}