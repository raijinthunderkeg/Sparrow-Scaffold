Pod::Spec.new do |s|
	s.name = 'SparrowScaffold'
	s.summary = 'Calendar with selection rules.'
	s.homepage = 'http://http://easy-pro.ru/'
	s.version  = '0.0.1'
  	s.license  = { :type => 'MIT', :file => 'LICENSE' }
	s.author = {
		'Igor Lepeshkin' => 'lis892009@yandex.ru'
	}
	s.source = {
		:git => 'https://github.com/raijinthunderkeg/Sparrow-Scaffold.git',
		:branch => 'master'
	}
	s.platform = :ios, '5.0'
	s.source_files = 'Classes/Common/*.{h,m}'
	s.requires_arc = true
end
