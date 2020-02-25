require 'test_helper'

class MessageTest < ActiveSupport::TestCase

	test "should create message" do
		message = Message.new
		message.author = "test"
		message.body = "test"
		message.publication_date = Time.now

		assert message.save
	end

	test "should not save message without body" do
		message = Message.new
		message.author = "test"
		message.publication_date = Time.now

		assert_not message.save
	end

	test "shoud not save message without author" do
		message = Message.new
		message.body = "author"
		message.publication_date = Time.now

		assert_not message.save
	end

	test "should not save message without date" do
		message = Message.new
		message.author = "test"
		message.body = "test"

		assert_not message.save
	end
end
