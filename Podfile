source 'https://cdn.cocoapods.org/'
platform :ios, '17.0'

project 'Legado.xcodeproj'

use_frameworks!

target 'Legado' do
  pod 'Alamofire'
  pod 'SwiftSoup', '2.11.3'
  pod 'GCDWebServer', '3.5.4'
  pod 'Kanna', '~> 5.3'
  pod 'SwCrypt', '~> 5.1.3'
end

target 'swiftLegadoTests' do
  pod 'Alamofire'
  pod 'SwiftSoup', '2.11.3'
  pod 'GCDWebServer', '3.5.4'
  pod 'Kanna', '~> 5.3'
  pod 'SwCrypt', '~> 5.1.3'
end

post_install do |installer|
  # Restore the raw RSA wrapper used by the original SwiftLegado parser.
  # The upstream app omitted its modified Pods/SwCrypt source from Git.
  swcrypt_path = installer.sandbox.root + 'SwCrypt/SwCrypt/SwCrypt.swift'
  swcrypt = swcrypt_path.read
  unless swcrypt.include?('public static func rawCrypt(')
    anchor = "\t\tfileprivate static func importFromDERKey("
    raise 'SwCrypt RSA patch anchor changed' unless swcrypt.scan(anchor).length == 1
    wrapper = <<~SWIFT.lines.map { |line| "\t\t" + line }.join
      public static func rawCrypt(_ data: Data, derKey: Data) throws -> (Data, Int) {
          let key = try importFromDERKey(derKey)
          defer { CCRSACryptorRelease!(key) }
          let blockSize = getKeySize(key)
          let output = try crypt(data, key: key)
          return (output, blockSize)
      }

    SWIFT
    swcrypt_path.chmod(0644)
    swcrypt_path.write(swcrypt.sub(anchor, wrapper + anchor))
  end

  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
    end
  end
end
