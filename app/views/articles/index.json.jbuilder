json.articles @articles  do |article|
  json.id article.id
  json.title article.title
  json.body article.body
  json.date article.created_at
  json.upvotes article.get_upvotes.size
  json.downvotes article.get_downvotes.size
end