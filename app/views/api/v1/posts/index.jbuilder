json.pagination @paginated_posts[0][:pagination]
json.resources @paginated_posts[1] do |post|
  json.body post.body
  json.title post.title
  json.link api_v1_post_path(post)
end