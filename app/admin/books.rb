ActiveAdmin.register Book do
  permit_params :genre, :author, :image, :title, :publisher, :year
end
