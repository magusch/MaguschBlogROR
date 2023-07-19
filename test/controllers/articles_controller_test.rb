require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get articles_path
    assert_response :success
  end

  def sign_in(user)
    post user_session_path, params: { user: { email: user.email, password: "your_password" } }
    #follow_redirect!
  end

  def sign_out
    delete destroy_user_session_path
    follow_redirect!
  end

  setup do
    @user = FactoryBot.create(:user) # Создаем пользователя с помощью фабрики
    sign_in @user # Входим в систему пользователя (имитация Devise)
    #@article = FactoryBot.create(:article)
    @article = Article.create(title: 'Hello World Setup', body: 'Lorem ipsum', status: 'public')
    articles(:one) # Предварительно созданный объект статьи для тестов
  end

  test "should check autorization" do
    sign_out
    get new_article_path
    assert_response :redirect
  end

  test "should create article" do
    assert_difference('Article.count') do
      post articles_path, params: { article: { title: 'New Article', body: 'Lorem ipsum', status: 'public' } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should update article" do
    patch article_path(@article), params: { article: { title: 'Updated Title' } }

    assert_redirected_to article_path(@article)
    @article.reload
    assert_equal 'Updated Title', @article.title
  end
end
