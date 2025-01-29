# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

use_frameworks!
workspace 'Modularization'

target 'GamesApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GamesApp
	pod 'Alamofire'
	pod 'Toast-Swift'
	pod 'Swinject'

end

target 'Common' do
  project '../GamesApp/Modules/Common/Common'
end

target 'Core' do
  project '../GamesApp/Modules/Core/Core'
	pod 'Swinject'
	pod 'Alamofire'
end

target 'GameDetail' do
  project '../GamesApp/Modules/GameDetail/GameDetail'
	pod 'Swinject'
	pod 'Alamofire'
end

target 'GameFavorites' do
  project '../GamesApp/Modules/GameFavorites/GameFavorites'
	pod 'Swinject'
end

target 'Homepage' do
  project '../GamesApp/Modules/Homepage/Homepage'
	pod 'Alamofire'
	pod 'Swinject'
end



