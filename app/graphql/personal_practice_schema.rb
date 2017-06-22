# example:所有文章标题内容用户评论
# query {
#   acticle(category: "all"){
#     title
#     body
#     user {
#       full_name
#     }
#     comments {
#       body
#     }
#
#   }
# }
PersonalPracticeSchema = GraphQL::Schema.define do
  query(Types::QueryType)
  mutation(MutationType)
end
