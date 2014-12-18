Pod::Spec.new do |s|

s.name         = "WSLViewAutoDismiss"
s.version      = "1.0.0"
s.summary      = "UIAlertView and UIActionSheet that dismiss automatically when app switches into the background."

s.description  = <<-DESC
The iOS documentation says that when an app goes into the background, certain things should happen to avoid confusion when it comes back into the foreground. One of those things is cancelling UIActionSheet's and UIAlertView's.

This project does exactly that automatically. As an added bonus, I also added some init methods with blocks rather than delegates.
DESC

s.homepage     = "https://github.com/sdarlington/WSLViewAutoDismiss"
s.license      = { :type => "Apache License, Version 2.0", :file => "LICENSE.txt" }
s.author             = "Stephen Darlington"
s.social_media_url = "http://twitter.com/sdarlington"
s.platform     = :ios, '5.1'
s.source       = { :git => "https://github.com/sdarlington/WSLViewAutoDismiss.git", :tag => "1.0.0" }
s.source_files  = 'WSLViewAutoDismiss/WSLViewAutoDismiss/WSL*AutoDismiss.{h,m}'
s.public_header_files = 'WSLViewAutoDismiss/WSLViewAutoDismiss/WSL*AutoDismiss.h'

end
