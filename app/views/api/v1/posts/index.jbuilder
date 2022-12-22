# json.resources @posts do |post|
#   json.body post.body
#   json.title post.title
#   json.link api_v1_post_path(post)
# end


json.array! @posts do |post|
  json.body post.body
  json.title post.title
  json.link api_v1_posts_path(post)
end