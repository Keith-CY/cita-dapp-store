defmodule CitaDappStore.PostsTest do
  use CitaDappStore.DataCase

  alias CitaDappStore.Posts

  describe "articles" do
    alias CitaDappStore.Posts.Article

    @valid_attrs %{content: "some content", title: "some title"}
    @update_attrs %{content: "some updated content", title: "some updated title"}
    @invalid_attrs %{content: nil, title: nil}

    def article_fixture(attrs \\ %{}) do
      {:ok, article} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Posts.create_article()

      article
    end

    test "list_articles/0 returns all articles" do
      article = article_fixture()
      assert Posts.list_articles() == [article]
    end

    test "get_article!/1 returns the article with given id" do
      article = article_fixture()
      assert Posts.get_article!(article.id) == article
    end

    test "create_article/1 with valid data creates a article" do
      assert {:ok, %Article{} = article} = Posts.create_article(@valid_attrs)
      assert article.content == "some content"
      assert article.title == "some title"
    end

    test "create_article/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_article(@invalid_attrs)
    end

    test "update_article/2 with valid data updates the article" do
      article = article_fixture()
      assert {:ok, article} = Posts.update_article(article, @update_attrs)
      assert %Article{} = article
      assert article.content == "some updated content"
      assert article.title == "some updated title"
    end

    test "update_article/2 with invalid data returns error changeset" do
      article = article_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_article(article, @invalid_attrs)
      assert article == Posts.get_article!(article.id)
    end

    test "delete_article/1 deletes the article" do
      article = article_fixture()
      assert {:ok, %Article{}} = Posts.delete_article(article)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_article!(article.id) end
    end

    test "change_article/1 returns a article changeset" do
      article = article_fixture()
      assert %Ecto.Changeset{} = Posts.change_article(article)
    end
  end
end
