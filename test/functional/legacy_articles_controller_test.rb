require 'test_helper'

class LegacyArticlesControllerTest < ActionController::TestCase
  setup do
    @legacy_article = legacy_articles(:one)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:legacy_articles)
  # end

  test "should get new" do
    get :new
    assert_response :success
  end

  # test "should create legacy_article" do
  #   assert_difference('LegacyArticle.count') do
  #     post :create, legacy_article: @legacy_article.attributes
  #   end

  #   assert_redirected_to legacy_article_path(assigns(:legacy_article))
  # end

  test "should show legacy_article" do
    get :show, id: @legacy_article.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @legacy_article.to_param
    assert_response :success
  end

  # test "should update legacy_article" do
  #   put :update, id: @legacy_article.to_param, legacy_article: @legacy_article.attributes
  #   assert_redirected_to legacy_article_path(assigns(:legacy_article))
  # end

  # test "should destroy legacy_article" do
  #   assert_difference('LegacyArticle.count', -1) do
  #     delete :destroy, id: @legacy_article.to_param
  #   end

  #   assert_redirected_to legacy_articles_path
  # end
end
