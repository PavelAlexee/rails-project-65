CATEGORYS = [ 'Электроника', 'Книги', 'Мебель', 'Одежда' ]

CATEGORYS.each do |categoty|
  Category.create(name: categoty)
end
