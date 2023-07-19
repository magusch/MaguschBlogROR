require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "should be valid with valid attributes" do
    article = Article.new(title: 'Valid Title', body: 'Valid Body')
    assert article.valid?
  end

  test "should be invalid without a title" do
    article = Article.new(body: 'Valid Body')
    assert_not article.valid?
  end

  test "should be invalid with less symbol than 10" do
    article = Article.new(title: 'Valid Title', body: 'Valid')
    assert_not article.valid?
  end

  # test "should belong to a user" do
  #   user = User.create(name: 'John Doe')
  #   article = Article.new(title: 'Title', body: 'Valid Bodys', user: user)
  #   assert_equal user, article.user
  # end

  test "should return correct word count" do
    article = Article.new(title: 'Title', body: 'This is a sample article.')
    assert_equal 25, article.body.length
  end
end
