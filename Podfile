source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!

target 'MVC' do
end

target 'MVP' do
end

target 'MVVM-Delegate' do
end

target 'MVVM-Rx' do
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
end

target 'Uber-RIBs' do
    pod 'RIBs', :git => 'https://github.com/uber/RIBs.git', :commit => 'b586fbf'
end

target 'Shared' do

  target 'SharedTests' do
    inherit! :search_paths
  end

end
