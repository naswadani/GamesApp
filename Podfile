# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'


source "https://github.com/naswadani/Modularization-Common-Podspec" 

use_frameworks!
workspace 'Modularization'

target 'GamesApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GamesApp
	pod 'Alamofire'
	pod 'Toast-Swift'
	pod 'Swinject'
	pod 'CommonPodSpec'

end

target 'Core' do
  project 'Modules/Core/Core'
	pod 'Swinject'
	pod 'Alamofire'
	pod 'CommonPodSpec'
end

target 'GameDetail' do
  project 'Modules/GameDetail/GameDetail'
	pod 'Swinject'
	pod 'Alamofire'
	pod 'CommonPodSpec'
end

target 'Homepage' do
  project 'Modules/Homepage/Homepage'
	pod 'Alamofire'
	pod 'Swinject'
	pod 'CommonPodSpec'
end



