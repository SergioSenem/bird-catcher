require 'test_helper'

class HashtagTest < ActiveSupport::TestCase

	test "should not save hashtag without value" do
		hashtag = Hashtag.new

		assert_not hashtag.save
	end
end
