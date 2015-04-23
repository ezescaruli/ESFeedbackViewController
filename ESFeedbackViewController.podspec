Pod::Spec.new do |s|

	s.name         = "ESFeedbackViewController"
	s.version      = "0.1.0"
	s.license      = "MIT"
	s.summary      = "iOS library to show a feedback screen within an application."
	s.homepage     = "https://github.com/ezescaruli/ESFeedbackViewController"
	s.author       = {"Ezequiel Scaruli" => "ezequiel.scaruli@gmail.com"}
	s.source       = {:git => "https://github.com/ezescaruli/ESFeedbackViewController.git", :tag => "0.1.0"}
	s.source_files = "ESFeedbackViewController/**/*.{h,m}"
	s.resources    = "ESFeedbackViewController/Storyboard/Feedback.storyboard"

end