class system-update {
	file {
		"/etc/apt/sources.list.d/10gen.list":
		owner => root,
		group => root,
		mode => 664,
		source => "/vagrant/vagrant_conf/puppet/conf/apt/10gen.list"
	}

	file {
		"/etc/mongodb.conf":
		owner => root,
		group => root,
		mode => 664,
		source => "/vagrant/vagrant_conf/puppet/conf/etc/mongodb.conf"
	}

	exec {
		'mongo-apt-key':
		cwd => '/tmp',
		command => "apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10",
		require => File['/etc/apt/sources.list.d/10gen.list'],
		notify => Exec['apt-get update'],
	}

	exec {
		'apt-get update':
		command => 'apt-get update',
	}

	$sysPackages = ["build-essential", "mongodb-10gen"]
	package {
		$sysPackages:
		ensure => installed,
		require => [Exec['apt-get update'], Exec['mongo-apt-key']],
	}
}