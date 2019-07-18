class ArticleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :text
end
