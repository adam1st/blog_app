json.article do
  json.id @article.id
  json.upvotes @article.get_upvotes.size
  json.downvotes @article.get_downvotes.size
end